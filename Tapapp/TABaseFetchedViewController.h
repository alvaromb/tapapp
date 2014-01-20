//
//  TABaseFetchedViewController.h
//  Tapapp
//
//  Created by Álvaro on 19/01/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TABaseFetchedViewController : UIViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

// Here should live all the empty views stuff

@end
