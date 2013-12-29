//
//  TACheckInViewController.m
//  Tapapp
//
//  Created by Álvaro on 29/12/13.
//  Copyright (c) 2013 Álvaro Medina Ballester. All rights reserved.
//

#import "TACheckInViewController.h"

@interface TACheckInViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *closeButton;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation TACheckInViewController

#pragma mark - Lazy instantiation

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
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

- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController) {
        _fetchedResultsController = [TALocalMapper allLocalsWithDelegate:self];
    }
    return _fetchedResultsController;
}

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Nuevo Check-in";
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -11;
        UIBarButtonItem *closeBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.closeButton];
        self.navigationItem.leftBarButtonItems = @[space, closeBarButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view addSubview:self.tableView];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fetchedResultsController.fetchedObjects.count;
}

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
    cell.distanceLabel.text = @"A 5 minutos";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Local *local = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
    NSString *checkInMessage = [NSString stringWithFormat:@"Check-in en %@", local.nombre];
    UIAlertView *checkIn = [[UIAlertView alloc] initWithTitle:@"Check-in"
                                                      message:checkInMessage
                                                     delegate:self
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"Ok", nil];
    [checkIn show];
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
