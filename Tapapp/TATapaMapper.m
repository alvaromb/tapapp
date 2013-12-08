//
//  TATapaMapper.m
//  Tapapp
//
//  Created by Álvaro on 08/12/13.
//  Copyright (c) 2013 Álvaro Medina Ballester. All rights reserved.
//

#import "TATapaMapper.h"

@implementation TATapaMapper


#pragma mark - Create

+ (void)insertTapa:(NSDictionary *)tapa
         inContext:(NSManagedObjectContext *)context
{
    Tapa *newTapa = [Tapa MR_createInContext:context];
    newTapa.nombre = tapa[@"nombre"];
    newTapa.path_imagen = tapa[@"path_imagen"];
    newTapa.rating = tapa[@"rating"];
}

+ (void)insertTapas:(NSArray *)tapas
          inContext:(NSManagedObjectContext *)context
{
    for (NSDictionary *tapa in tapas) {
        [self insertTapa:tapa inContext:context];
    }
}


#pragma mark - Read

+ (NSFetchedResultsController *)fetchedResultsControllerWithDelegate:(id)delegate
                                                           inContext:(NSManagedObjectContext *)context
{
    return [Tapa MR_fetchAllSortedBy:nil ascending:NO withPredicate:nil groupBy:nil delegate:delegate];
}


#pragma mark - Update

#pragma mark - Delete

#pragma mark - Dummy data

+ (void)insertDummyTapas

{
    [Tapa MR_truncateAllInContext:[NSManagedObjectContext MR_contextForCurrentThread]];
    NSDictionary *tapa01 = @{@"nombre"      : @"Patatas bravas",
                             @"path_imagen" : @"1.jpg",
                             @"rating"      : @(5.0)};
    NSDictionary *tapa02 = @{@"nombre"      : @"Pincho de tortilla",
                             @"path_imagen" : @"2.jpg",
                             @"rating"      : @(3.5)};
    NSDictionary *tapa03 = @{@"nombre"      : @"Morcilla",
                             @"path_imagen" : @"3.jpg",
                             @"rating"      : @(4.5)};
    NSDictionary *tapa04 = @{@"nombre"      : @"Calamares",
                             @"path_imagen" : @"4.jpg",
                             @"rating"      : @(5.0)};
    NSDictionary *tapa05 = @{@"nombre"      : @"Queso con arándanos",
                             @"path_imagen" : @"5.jpg",
                             @"rating"      : @(5.0)};
    NSDictionary *tapa06 = @{@"nombre"      : @"Llonguet de serrano",
                             @"path_imagen" : @"6.jpg",
                             @"rating"      : @(5.0)};
    NSArray *dummyTapas = @[tapa01, tapa02, tapa03, tapa04, tapa05, tapa06];
    [self insertTapas:dummyTapas inContext:[NSManagedObjectContext MR_contextForCurrentThread]];
    NSError *error;
    [[NSManagedObjectContext MR_contextForCurrentThread] save:&error];
    if (error) {
        NSLog(@"Error saving %@", [error description]);
    }
}

@end
