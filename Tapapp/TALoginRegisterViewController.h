//
//  TALoginRegisterViewController.h
//  Tapapp
//
//  Created by Álvaro on 26/01/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

@protocol TALoginDelegate;

@interface TALoginRegisterViewController : UIViewController

@property (weak, nonatomic) id<TALoginDelegate> delegate;

@end

@protocol TALoginDelegate <NSObject>

@required

- (void)loginRegisterDidFinishedWithSuccess:(TALoginRegisterViewController *)viewController;
- (void)loginRegisterDidCancel:(TALoginRegisterViewController *)viewController;

@end