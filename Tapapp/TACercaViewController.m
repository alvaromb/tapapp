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
@property (strong, nonatomic) UIButton *checkInButton;
@property (strong, nonatomic) UIButton *newBarButton;

@end

@implementation TACercaViewController


#pragma mark - Lazy instantiation

- (MKMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[MKMapView alloc] initWithFrame:CGRectZero];
        _mapView.delegate = self;
        _mapView.zoomEnabled = YES;
        _mapView.scrollEnabled = YES;
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MKUserTrackingModeFollow;
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
        _fetchedResultsController = [TALocalMapper allLocalsWithDelegate:self];
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

- (UIButton *)checkInButton
{
    if (!_checkInButton) {
        _checkInButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        [_checkInButton setTitle:@"Check-In" forState:UIControlStateNormal];
        [_checkInButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_checkInButton addTarget:self action:@selector(newCheckIn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkInButton;
}

- (UIButton *)newBarButton
{
    if (!_newBarButton) {
        _newBarButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        [_newBarButton setTitle:@"Nuevo Bar" forState:UIControlStateNormal];
        [_newBarButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [_newBarButton addTarget:self action:@selector(newBar) forControlEvents:UIControlEventTouchUpInside];
    }
    return _newBarButton;
}


#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"cerca.png"];
        self.title = @"Cerca";
        UIBarButtonItem *checkInBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.checkInButton];
        self.navigationItem.leftBarButtonItem = checkInBarButton;
        UIBarButtonItem *newBarBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.newBarButton];
        self.navigationItem.rightBarButtonItem = newBarBarButton;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
	[self.view addSubview:self.mapView];
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.refreshControl];
    
    // Add the annotations of each local
    // TODO: subclass MKPointAnnotation and add custom annotation
    for (Local *local in self.fetchedResultsController.fetchedObjects) {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = CLLocationCoordinate2DMake([local.latitud doubleValue], [local.longitud doubleValue]);
        annotation.title = local.nombre;
        [self.mapView addAnnotation:annotation];
    }
    MKCoordinateRegion region = MKCoordinateRegionForMapRect([self mapRectToFitAllAnnotations]);
    [self.mapView setRegion:region];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mapView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    self.tableView.frame = CGRectMake(0, 200, self.view.bounds.size.width, self.view.bounds.size.height - navigationBarHeight);
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
    Local *local = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = local.nombre;
    return cell;
}


#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//    CLLocationCoordinate2D coordinate = userLocation.location.coordinate;
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000);
//    mapView.region = region;
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

- (void)newCheckIn
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Nuevo check-in" message:Nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alertView show];
}

- (void)newBar
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Nuevo bar" message:Nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alertView show];
}

- (MKMapRect)mapRectToFitAllAnnotations
{
    MKMapPoint points[[self.mapView.annotations count]];
    for (int i = 0; i < [self.mapView.annotations count]; i++) {
        MKPointAnnotation *annotation = [self.mapView.annotations objectAtIndex:i];
        points[i] = MKMapPointForCoordinate(annotation.coordinate);
    }
    MKPolygon *polygon = [MKPolygon polygonWithPoints:points count:[self.mapView.annotations count]];
    return [polygon boundingMapRect];
}

@end
