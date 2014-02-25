//
//  TACheckInViewController.m
//  Tapapp
//
//  Created by Álvaro on 29/12/13.
//  Copyright (c) 2013 Álvaro Medina Ballester. All rights reserved.
//

#import "TACheckInViewController.h"

@interface TACheckInViewController ()

@property (strong, nonatomic) UIButton *closeButton;
@property (strong, nonatomic) TTTLocationFormatter *locationFormatter;

@end

@implementation TACheckInViewController

#pragma mark - Lazy instantiation

- (TTTLocationFormatter *)locationFormatter
{
    if (!_locationFormatter) {
        _locationFormatter = [[TTTLocationFormatter alloc] init];
    }
    return _locationFormatter;
}

- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        [_closeButton setTitle:@"Cancelar" forState:UIControlStateNormal];
        [_closeButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(cancelCheckIn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Nuevo Check-in";
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -15;
        UIBarButtonItem *closeBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.closeButton];
        self.navigationItem.leftBarButtonItems = @[space, closeBarButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view addSubview:self.tableView];
    self.fetchedResultsController = [TALocalMapper allLocalsWithDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"localCellIdentifier";
    TALocalCercaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[TALocalCercaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(TALocalCercaCell *)cell
          atIndexPath:(NSIndexPath *)indexPath
{
    Local *local = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
    cell.localLabel.text = local.nombre;
    NSString *distancia = [self.locationFormatter stringFromDistance:[local.distancia doubleValue]];
    cell.distanceLabel.text = [NSString stringWithFormat:@"A %@", distancia];
    [cell.localImageView setImageWithURL:[NSURL URLWithString:[TAAPIURL stringByAppendingString:local.path_imagen]]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Local *local = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
    [[TATappapAPI sharedInstance] checkinLocal:[MTLManagedObjectAdapter modelOfClass:MTLLocal.class fromManagedObject:local error:nil] completionBlock:^(id response) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Actions

- (void)cancelCheckIn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
