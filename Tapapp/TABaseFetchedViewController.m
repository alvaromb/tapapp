//
//  TABaseFetchedViewController.m
//  Tapapp
//
//  Created by Álvaro on 19/01/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "TABaseFetchedViewController.h"

@implementation TABaseFetchedViewController

@synthesize fetchedResultsController = _fetchedResultsController;

#pragma mark - Lazy instantiation

- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController) {
        _fetchedResultsController = [[NSFetchedResultsController alloc] init];
        _fetchedResultsController.delegate = self;
        [_fetchedResultsController performFetch:nil];
    }
    return _fetchedResultsController;
}

- (void)setFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    _fetchedResultsController.delegate = nil;
    _fetchedResultsController = fetchedResultsController;
}

#pragma mark - Lifecycle

- (void)dealloc
{
    _fetchedResultsController = nil;
}

@end
