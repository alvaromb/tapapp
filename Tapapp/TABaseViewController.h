//
//  TABaseViewController.h
//  Tapapp
//
//  Created by Álvaro on 24/12/13.
//  Copyright (c) 2013 Álvaro Medina Ballester. All rights reserved.
//

#import "TACheckInViewController.h"
#import "TANuevoBarViewController.h"
#import "TABaseTableViewController.h"

@interface TABaseViewController : TABaseTableViewController

@property (strong, nonatomic) UIButton *checkInButton;
@property (strong, nonatomic) UIButton *newBarButton;

@end
