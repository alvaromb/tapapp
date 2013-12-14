//
//  TALocalMapper.h
//  Tapapp
//
//  Created by Álvaro on 09/12/13.
//  Copyright (c) 2013 Álvaro Medina Ballester. All rights reserved.
//

#import "Local.h"

@interface TALocalMapper : NSObject

#pragma mark - Create
+ (void)insertLocal:(NSDictionary *)local
          inContext:(NSManagedObjectContext *)context;
+ (void)insertLocales:(NSArray *)locales
            inContext:(NSManagedObjectContext *)context;

#pragma mark - Read
+ (NSFetchedResultsController *)allLocalsWithDelegate:(id)delegate;

#pragma mark - Update

#pragma mark - Delete

@end
