//
//  TALocalMapper.m
//  Tapapp
//
//  Created by Álvaro on 09/12/13.
//  Copyright (c) 2013 Álvaro Medina Ballester. All rights reserved.
//

#import "TALocalMapper.h"

@implementation TALocalMapper

#pragma mark - Create

+ (void)insertLocal:(NSDictionary *)local
          inContext:(NSManagedObjectContext *)context
{
    Local *newLocal = [Local MR_createInContext:context];
    newLocal.nombre = local[@"nombre"];
    newLocal.latitud = local[@"latitud"];
    newLocal.longitud = local[@"longitud"];
    newLocal.calle = local[@"calle"];
    newLocal.zip = local[@"zip"];
}

+ (void)insertLocales:(NSArray *)locales
            inContext:(NSManagedObjectContext *)context
{
    for (NSDictionary *local in locales) {
        [self insertLocal:local inContext:context];
    }
}

#pragma mark - Read

+ (NSFetchedResultsController *)allLocalsWithDelegate:(id)delegate
{
    return [Local MR_fetchAllGroupedBy:nil withPredicate:nil sortedBy:@"distancia" ascending:YES delegate:delegate];
}

+ (NSFetchedResultsController *)commentsForLocal:(Local *)local
                                    withDelegate:(id)delegate
{
    return [Comentario MR_fetchAllGroupedBy:nil withPredicate:[NSPredicate predicateWithFormat:@"local == %@", local] sortedBy:@"fecha" ascending:NO delegate:delegate];
}

@end
