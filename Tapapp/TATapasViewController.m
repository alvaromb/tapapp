//
//  TATapasViewController.m
//  Tapapp
//
//  Created by alvaro on 25/11/13.
//  Copyright (c) 2013 alvaromb. All rights reserved.
//

#import "TATapasViewController.h"

@interface TATapasViewController ()

@end

@implementation TATapasViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"tapas.png"];
        self.title = @"Tapas";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
