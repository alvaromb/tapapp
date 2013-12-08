//
//  TAPerfilViewController.m
//  Tapapp
//
//  Created by alvaro on 25/11/13.
//  Copyright (c) 2013 alvaromb. All rights reserved.
//

#import "TAPerfilViewController.h"

@interface TAPerfilViewController ()

@end

@implementation TAPerfilViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"perfil.png"];
        self.title = @"Perfil";
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
