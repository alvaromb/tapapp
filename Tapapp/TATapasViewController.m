//
//  TATapasViewController.m
//  Tapapp
//
//  Created by alvaro on 25/11/13.
//  Copyright (c) 2013 alvaromb. All rights reserved.
//

#import "TATapasViewController.h"

@interface TATapasViewController ()

@property (strong, nonatomic) NSFetchedResultsController *searchedResultsController;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UISearchDisplayController *searchController;
@property (strong, nonatomic) TTTLocationFormatter *locationFormatter;

@end

@implementation TATapasViewController

#pragma mark - Lazy instantiation

- (TTTLocationFormatter *)locationFormatter
{
    if (!_locationFormatter) {
        _locationFormatter = [[TTTLocationFormatter alloc] init];
    }
    return _locationFormatter;
}

- (NSFetchedResultsController *)searchedResultsController
{
    if (!_searchedResultsController) {
        _searchedResultsController = [TATapaMapper fetchedResultsControllerWithSearch:self.searchController.searchBar.text delegate:self inContext:[NSManagedObjectContext MR_contextForCurrentThread]];
    }
    return _searchedResultsController;
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (UISearchDisplayController *)searchController
{
    if (!_searchController) {
        _searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
        _searchController.delegate = self;
        _searchController.searchResultsDelegate = self;
        _searchController.searchResultsDataSource = self;
    }
    return _searchController;
}

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"tapas.png"];
        self.title = @"Tapas";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view addSubview:self.tableView];
    self.searchController.searchResultsTableView.rowHeight = 50.0f;
    self.fetchedResultsController = [TATapaMapper fetchedResultsControllerWithDelegate:self inContext:[NSManagedObjectContext MR_contextForCurrentThread]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.searchBar sizeToFit];
    [self.tableView setTableHeaderView:self.searchBar];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id sectionInfo = [[[self fetchedResultsControllerForTableView:tableView] sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"tapaCellIdentifier";
    TATapaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[TATapaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [self configureCell:cell atIndexPath:indexPath withFetchedResultsController:[self fetchedResultsControllerForTableView:tableView]];
    return cell;
}

- (void)configureCell:(TATapaCell *)cell
          atIndexPath:(NSIndexPath *)indexPath
withFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    Tapa *tapa = [fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
    cell.tapaLabel.text = tapa.nombre;
    NSString *distancia = [self.locationFormatter stringFromDistance:[tapa.local.distancia doubleValue]];
    cell.distanciaLabel.text = [NSString stringWithFormat:@"A %@", distancia];
    if (tapa.path_imagen) {
        [cell.tapaImageView setImageWithURL:[NSURL URLWithString:tapa.path_imagen]];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TATapaViewController *tapaViewController = [[TATapaViewController alloc] init];
    [tapaViewController setTapa:[self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:tapaViewController animated:YES];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    UITableView *tableView = (controller == self.fetchedResultsController) ? self.tableView : self.searchController.searchResultsTableView;
    [tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = (controller == self.fetchedResultsController) ? self.tableView : self.searchController.searchResultsTableView;
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            [self configureCell:(TATapaCell *)[tableView cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath
   withFetchedResultsController:controller];
            break;
        }
        default: {
            break;
        }
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    UITableView *tableView = (controller == self.fetchedResultsController) ? self.tableView : self.searchController.searchResultsTableView;
    [tableView endUpdates];
}

#pragma mark - UISearchDisplayDelegate

- (NSFetchedResultsController *)fetchedResultsControllerForTableView:(UITableView *)tableView
{
    return (tableView == self.tableView) ? self.fetchedResultsController : self.searchedResultsController;
}

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSInteger)scope
{
    self.searchedResultsController.delegate = nil;
    self.searchedResultsController = nil;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willUnloadSearchResultsTableView:(UITableView *)tableView
{
    self.searchedResultsController.delegate = nil;
    self.searchedResultsController = nil;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[self.searchController.searchBar selectedScopeButtonIndex]];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:self.searchController.searchBar.text scope:[self.searchController.searchBar selectedScopeButtonIndex]];
    return YES;
}

@end
