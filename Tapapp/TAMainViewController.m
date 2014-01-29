//
//  TAMainViewController.m
//  Tapapp
//
//  Created by Álvaro on 31/12/13.
//  Copyright (c) 2013 Álvaro Medina Ballester. All rights reserved.
//

#import "TAMainViewController.h"

@interface TAMainViewController ()

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UILabel *loadingLabel;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation TAMainViewController

#pragma mark - Lazy instantiation

- (UIActivityIndicatorView *)activityIndicator
{
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activityIndicator;
}

- (UILabel *)loadingLabel
{
    if (!_loadingLabel) {
        _loadingLabel = [[UILabel alloc] init];
        _loadingLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:14];
        _loadingLabel.textColor = [UIColor grayColor];
        _loadingLabel.textAlignment = NSTextAlignmentCenter;
        _loadingLabel.text = @"Obteniendo posición";
    }
    return _loadingLabel;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:26];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"Tapapp";
    }
    return _titleLabel;
}

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.loadingLabel];
    [self.view addSubview:self.activityIndicator];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationAvailable) name:@"locationAvailable" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.titleLabel.frame   = CGRectMake(0, 100, self.view.bounds.size.width, 30);
    self.loadingLabel.frame = CGRectMake(0, 140, self.view.bounds.size.width, 18);
    self.activityIndicator.frame = CGRectMake((self.view.bounds.size.width - self.activityIndicator.frame.size.width)/2, 165, self.activityIndicator.frame.size.width, self.activityIndicator.frame.size.height);
    [self.activityIndicator startAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Actions

- (void)locationAvailable
{
    [TATapaMapper insertDummyTapas];
    [self.activityIndicator stopAnimating];
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:@"app_token"];
    if (token) {
        [self presentAppOnceLoggedIn];
    }
    else {
        [self presentLoginWindow];
    }
}

- (void)presentAppOnceLoggedIn
{
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    UINavigationController *cercaNavController = [[UINavigationController alloc] initWithRootViewController:[[TACercaViewController alloc] init]];
    UINavigationController *tapasNavController = [[UINavigationController alloc] initWithRootViewController:[[TATapasViewController alloc] init]];
    UINavigationController *perfilNavController = [[UINavigationController alloc] initWithRootViewController:[[TAPerfilViewController alloc] init]];
    tabBarController.viewControllers = @[cercaNavController, tapasNavController, perfilNavController];
    [self presentViewController:tabBarController animated:YES completion:^{
        [self.activityIndicator stopAnimating];
        self.activityIndicator = nil;
        self.titleLabel = nil;
        self.loadingLabel = nil;
    }];
}

- (void)presentLoginWindow
{
    TALoginRegisterViewController *loginViewController = [[TALoginRegisterViewController alloc] init];
    loginViewController.delegate = self;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:loginViewController] animated:YES completion:nil];
}

#pragma mark - TALoginDelegate

- (void)loginRegisterDidCancel:(TALoginRegisterViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Error al registrarse"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Ok", nil];
        [alertView show];
    }];
}

- (void)loginRegisterDidFinishedWithSuccess:(TALoginRegisterViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Enhorabuena!"
                                                            message:@"Te has registrado correctamente"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Ok", nil];
        [alertView show];
    }];
}

@end
