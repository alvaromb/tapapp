//
//  TATapaMapper.h
//  Tapapp
//
//  Created by Álvaro on 08/12/13.
//  Copyright (c) 2013 Álvaro Medina Ballester. All rights reserved.
//

#import "Tapa.h"
#import "TipoTapa.h"
#import "Comentario.h"
#import "TALocalMapper.h"

@interface TATapaMapper : NSObject

#pragma mark - Create
+ (void)insertTapa:(NSDictionary *)tapa
         inContext:(NSManagedObjectContext *)context;
+ (void)insertTapas:(NSArray *)tapas
          inContext:(NSManagedObjectContext *)context;

#pragma mark - Read
+ (NSFetchedResultsController *)fetchedResultsControllerWithDelegate:(id)delegate
                                                           inContext:(NSManagedObjectContext *)context;
+ (NSFetchedResultsController *)fetchedResultsControllerWithSearch:(NSString *)search
                                                          delegate:(id)delegate
                                                         inContext:(NSManagedObjectContext *)context;
+ (NSFetchedResultsController *)fetchedTapasForLocal:(NSString *)local
                                            delegate:(id)delegate
                                           inContext:(NSManagedObjectContext *)context;

#pragma mark - Update

#pragma mark - Delete

#pragma mark - Dummy data
+ (void)insertDummyTapas;

@end
