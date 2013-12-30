//
//  TANuevoBarViewController.m
//  Tapapp
//
//  Created by Álvaro on 30/12/13.
//  Copyright (c) 2013 Álvaro Medina Ballester. All rights reserved.
//

#import "TANuevoBarViewController.h"

@interface TANuevoBarViewController ()

@property (strong, nonatomic) UIButton *closeButton;

@end

@implementation TANuevoBarViewController

#pragma mark - Lazy instantiation

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
        self.title = @"Nuevo Bar";
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
	self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)cancelCheckIn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
