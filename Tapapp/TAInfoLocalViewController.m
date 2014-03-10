//
//  TAInfoLocalViewController.m
//  Tapapp
//
//  Created by Álvaro on 04/01/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "TAInfoLocalViewController.h"

@interface TAInfoLocalViewController ()

@property (strong, nonatomic) UILabel *localLabel;
@property (strong, nonatomic) UILabel *descripcionLabel;
@property (strong, nonatomic) UIImageView *localImageView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) UIButton *favoritoButton;
@property (strong, nonatomic) UIButton *comentariosButton;
@property (strong, nonatomic) UIButton *addTapaButton;
@property (strong, nonatomic) UIButton *directionsButton;

@end

@implementation TAInfoLocalViewController

#pragma mark - Lazy instantiation

- (UILabel *)localLabel
{
    if (!_localLabel) {
        _localLabel = [[UILabel alloc] init];
        _localLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
        _localLabel.textColor = [UIColor blackColor];
        _localLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _localLabel;
}

- (UILabel *)descripcionLabel
{
    if (!_descripcionLabel) {
        _descripcionLabel = [[UILabel alloc] init];
        _descripcionLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        _descripcionLabel.textColor = [UIColor blackColor];
        _descripcionLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _descripcionLabel;
}

- (UIImageView *)localImageView
{
    if (!_localImageView) {
        _localImageView = [[UIImageView alloc] init];
    }
    return _localImageView;
}

//- (NSFetchedResultsController *)fetchedResultsController
//{
//    if (!_fetchedResultsController) {
//        _fetchedResultsController = [TATapaMapper fetchedTapasForLocal:self.local.nombre delegate:self inContext:[NSManagedObjectContext MR_contextForCurrentThread]];
//    }
//    return _fetchedResultsController;
//}

- (UIButton *)favoritoButton
{
    if (!_favoritoButton) {
        _favoritoButton = [[UIButton alloc] init];
        _favoritoButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_favoritoButton setTitle:@"Añadir favorito" forState:UIControlStateNormal];
        [_favoritoButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_favoritoButton addTarget:self action:@selector(addFavorito) forControlEvents:UIControlEventTouchUpInside];
    }
    return _favoritoButton;
}

- (UIButton *)comentariosButton
{
    if (!_comentariosButton) {
        _comentariosButton = [[UIButton alloc] init];
        _comentariosButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_comentariosButton setTitle:@"Comentarios (-)" forState:UIControlStateNormal];
        [_comentariosButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_comentariosButton addTarget:self action:@selector(viewComments) forControlEvents:UIControlEventTouchUpInside];
    }
    return _comentariosButton;
}

- (UIButton *)addTapaButton
{
    if (!_addTapaButton) {
        _addTapaButton = [[UIButton alloc] init];
        _addTapaButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_addTapaButton setTitle:@"Añadir tapa" forState:UIControlStateNormal];
        [_addTapaButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_addTapaButton addTarget:self action:@selector(addTapa) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addTapaButton;
}

- (UIButton *)directionsButton
{
    if (!_directionsButton) {
        _directionsButton = [[UIButton alloc] init];
        _directionsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_directionsButton setTitle:@"Cómo llegar" forState:UIControlStateNormal];
        [_directionsButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_directionsButton addTarget:self action:@selector(getDirections) forControlEvents:UIControlEventTouchUpInside];
    }
    return _directionsButton;
}

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Local";
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view addSubview:self.localLabel];
    [self.view addSubview:self.descripcionLabel];
    [self.view addSubview:self.localImageView];
    [self.view addSubview:self.favoritoButton];
    [self.view addSubview:self.comentariosButton];
    [self.view addSubview:self.addTapaButton];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.directionsButton];
//    self.fetchedResultsController = [TATapaMapper fetchedTapasForLocal:self.local
//                                                              delegate:self
//                                                             inContext:[NSManagedObjectContext MR_contextForCurrentThread]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.localLabel.frame           = CGRectMake(0, 20, self.view.bounds.size.width, 22);
    self.descripcionLabel.frame     = CGRectMake(0, 50, self.view.bounds.size.width, 20);
    self.localImageView.frame       = CGRectMake(0, 0, 0, 0);
    self.favoritoButton.frame       = CGRectMake(10, 140, 150, 30);
    self.comentariosButton.frame    = CGRectMake(160, 140, 150, 30);
    self.addTapaButton.frame        = CGRectMake(10, 175, 150, 30);
    self.tableView.frame            = CGRectMake(0, 210, 320, self.view.frame.size.height - 210);
    self.directionsButton.frame     = CGRectMake(160, 175, 150, 30);
    
    self.localLabel.text = self.local.nombre;
    self.descripcionLabel.text = self.local.calle;
    NSInteger numberOfComments = [[self.local valueForKeyPath:@"comentarios.@count"] integerValue];
    [self.comentariosButton setTitle:[NSString stringWithFormat:@"Comentarios (%d)", numberOfComments] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TapaCellIdentifier";
    TATapaCell *cell = (TATapaCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[TATapaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Tapa *tapa = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
    TATapaCell *tapaCell = (TATapaCell *)cell;
    tapaCell.tapaLabel.text = tapa.nombre;
    if (tapa.path_imagen) {
        [tapaCell.tapaImageView setImageWithURL:[NSURL URLWithString:tapa.path_imagen]];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TATapaViewController *tapaViewController = [[TATapaViewController alloc] init];
    [tapaViewController setTapa:[self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:tapaViewController animated:YES];
}

#pragma mark - Actions

- (void)addFavorito
{
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    NSString *userCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_code"];
    User *selfUser = [User MR_findFirstByAttribute:@"identifier" withValue:userCode inContext:context];
    [selfUser addFavsObject:self.local];
    NSError *error = nil;
    [context save:&error];
    if (error) {
        NSLog(@"Error putting favorites %@", error);
    }
    else {
        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@ añadido a favoritos", self.local.nombre]];
    }
}

- (void)viewComments
{
    TAComentariosLocalViewController *comentariosViewController = [[TAComentariosLocalViewController alloc] init];
    [comentariosViewController setLocal:self.local];
    [comentariosViewController setFetchedResultsController:[TALocalMapper commentsForLocal:self.local withDelegate:comentariosViewController]];
    [self.navigationController pushViewController:comentariosViewController animated:YES];
}

- (void)addTapa
{
    TAAddTapaViewController *vc = [[TAAddTapaViewController alloc] init];
    [vc setLocal:self.local];
    UINavigationController *addTapaViewController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:addTapaViewController animated:YES completion:nil];
}

- (void)getDirections
{
    MKPlacemark *place = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(self.local.latitud.floatValue, self.local.longitud.floatValue) addressDictionary: nil];
    MKMapItem* destination = [[MKMapItem alloc] initWithPlacemark: place];
    destination.name = self.local.nombre;
    NSArray* items = [[NSArray alloc] initWithObjects: destination, nil];
    NSDictionary* options = [[NSDictionary alloc] initWithObjectsAndKeys:
                             MKLaunchOptionsDirectionsModeDriving,
                             MKLaunchOptionsDirectionsModeKey, nil];
    [MKMapItem openMapsWithItems: items launchOptions: options];
}

@end
