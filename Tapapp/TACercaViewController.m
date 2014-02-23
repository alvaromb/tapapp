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
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) TTTLocationFormatter *locationFormatter;

@end

@implementation TACercaViewController

#pragma mark - Lazy instantiation

- (TTTLocationFormatter *)locationFormatter
{
    if (!_locationFormatter) {
        _locationFormatter = [[TTTLocationFormatter alloc] init];
    }
    return _locationFormatter;
}

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
        self.fetchedResultsController = [TALocalMapper allLocalsWithDelegate:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.refreshControl];
    self.fetchedResultsController = [TALocalMapper allLocalsWithDelegate:self];
    
    // Add the annotations of each local
    // TODO: subclass MKPointAnnotation and add custom annotation
    for (Local *local in self.fetchedResultsController.fetchedObjects) {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = CLLocationCoordinate2DMake([local.latitud doubleValue], [local.longitud doubleValue]);
        annotation.title = local.nombre;
        [self.mapView addAnnotation:annotation];
    }
    MKPointAnnotation *userPositionAnnotation = [[MKPointAnnotation alloc] init];
    userPositionAnnotation.coordinate = [[TALocationManager sharedInstance] lastLocation].coordinate;
    userPositionAnnotation.title = @"Yo";
    [self.mapView addAnnotation:userPositionAnnotation];
    
//    if (self.fetchedResultsController.fetchedObjects.count > 0) {
        MKCoordinateRegion region = MKCoordinateRegionForMapRect([self mapRectToFitAllAnnotations]);
        [self.mapView setRegion:region];
//    }    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mapView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    self.tableView.frame = CGRectMake(0, 200, self.view.bounds.size.width, self.view.bounds.size.height - navigationBarHeight);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.fetchedResultsController.fetchedObjects.count == 0) {
        [self.refreshControl beginRefreshing];
        [self refreshTapas];
    }
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"tapaCercaCellIdentifier";
    TALocalCercaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
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
    TAInfoLocalViewController *viewController = [[TAInfoLocalViewController alloc] init];
    [viewController setFetchedResultsController:[TATapaMapper fetchedTapasForLocal:local
                                                                         delegate:viewController
                                                                        inContext:[NSManagedObjectContext MR_contextForCurrentThread]]];
    [viewController setLocal:local];
    [self.navigationController pushViewController:viewController animated:YES];
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
    [[TATappapAPI sharedInstance] listNearLocalsWithinLocation:[[TALocationManager sharedInstance] lastLocation].coordinate completionBlock:^(id response) {
        [self.refreshControl endRefreshing];
    }];
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
