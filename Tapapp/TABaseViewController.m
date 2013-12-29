//
//  TABaseViewController.m
//  Tapapp
//
//  Created by Álvaro on 24/12/13.
//  Copyright (c) 2013 Álvaro Medina Ballester. All rights reserved.
//

#import "TABaseViewController.h"

@interface TABaseViewController ()

@end

@implementation TABaseViewController

#pragma mark - Lazy instantiation

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
        // Hack to align the UIBarButtons in iOS 7 
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -11;
        UIBarButtonItem *checkInBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.checkInButton];
        self.navigationItem.leftBarButtonItems = @[space, checkInBarButton];
        UIBarButtonItem *newBarBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.newBarButton];
        self.navigationItem.rightBarButtonItems = @[space, newBarBarButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UINavigationBar actions

- (void)newCheckIn
{
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Nuevo check-in" message:Nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//    [alertView show];
    UINavigationController *viewController = [[UINavigationController alloc] initWithRootViewController:[[TACheckInViewController alloc] init]];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)newBar
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Nuevo bar" message:Nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alertView show];
}

@end
