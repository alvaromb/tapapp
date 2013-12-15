//
//  TAAppDelegate.h
//  Tapapp
//
//  Created by Álvaro on 07/12/13.
//  Copyright (c) 2013 Álvaro Medina Ballester. All rights reserved.
//

#import "TATapaMapper.h"
#import "TALocationManager.h"
#import "TACercaViewController.h"
#import "TATapasViewController.h"
#import "TAPerfilViewController.h"

@interface TAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (NSURL *)applicationDocumentsDirectory;

@end
