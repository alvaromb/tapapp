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

- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController) {
        _fetchedResultsController = [TATapaMapper fetchedTapasForLocal:self.local.nombre delegate:self inContext:[NSManagedObjectContext MR_contextForCurrentThread]];
    }
    return _fetchedResultsController;
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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.localLabel.frame = CGRectMake(0, 20, self.view.bounds.size.width, 22);
    self.descripcionLabel.frame = CGRectMake(0, 50, self.view.bounds.size.width, 20);
    self.localImageView.frame = CGRectMake(0, 0, 0, 0);
    
    self.localLabel.text = self.local.nombre;
    self.descripcionLabel.text = self.local.calle;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
