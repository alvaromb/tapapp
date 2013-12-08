//
//  TACercaViewController.m
//  Tapapp
//
//  Created by alvaro on 25/11/13.
//  Copyright (c) 2013 alvaromb. All rights reserved.
//

#import "TACercaViewController.h"

@interface TACercaViewController ()

@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation TACercaViewController


#pragma mark - Lazy instantiation

- (MKMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[MKMapView alloc] initWithFrame:CGRectZero];
        _mapView.zoomEnabled = NO;
        _mapView.scrollEnabled = NO;
    }
    return _mapView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController) {
        _fetchedResultsController = [TATapaMapper fetchedResultsControllerWithDelegate:self
                                                                             inContext:[NSManagedObjectContext MR_contextForCurrentThread]];
    }
    return _fetchedResultsController;
}

- (UIRefreshControl *)refreshControl
{
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(refreshTapas) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}


#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"cerca.png"];
        self.title = @"Cerca";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view addSubview:self.mapView];
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.refreshControl];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mapView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    self.tableView.frame = CGRectMake(0, 200, self.view.bounds.size.width, self.view.bounds.size.height - 200 - navigationBarHeight);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"tapaCercaCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    Tapa *tapa = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = tapa.nombre;
    return cell;
}


#pragma mark - Actions

- (void)refreshTapas
{
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.refreshControl endRefreshing];
    });
}

@end
