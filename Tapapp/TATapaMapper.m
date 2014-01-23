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
    return [Tapa MR_fetchAllSortedBy:@"local.distancia" ascending:YES withPredicate:nil groupBy:nil delegate:delegate];
}

+ (NSFetchedResultsController *)fetchedResultsControllerWithSearch:(NSString *)search
                                                          delegate:(id)delegate
                                                         inContext:(NSManagedObjectContext *)context
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nombre CONTAINS[cd] %@", search];
    return [Tapa MR_fetchAllSortedBy:@"local.distancia" ascending:YES withPredicate:predicate groupBy:nil delegate:delegate];
}

+ (NSFetchedResultsController *)fetchedTapasForLocal:(NSString *)local
                                            delegate:(id)delegate
                                           inContext:(NSManagedObjectContext *)context
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"local.nombre == %@", local];
    return [Tapa MR_fetchAllGroupedBy:nil withPredicate:predicate sortedBy:nil ascending:NO];
}

#pragma mark - Update

#pragma mark - Delete

#pragma mark - Dummy data

+ (void)insertDummyTapas

{
    NSManagedObjectContext *context = [NSManagedObjectContext MR_contextForCurrentThread];
    [Tapa MR_truncateAllInContext:context];
    [Local MR_truncateAllInContext:context];
    [Comentario MR_truncateAllInContext:context];
    
    TALocationManager *locationManager = [TALocationManager sharedInstance];
    
    Tapa *newTapa01 = [Tapa MR_createInContext:context];
    newTapa01.nombre = @"Patatas bravas";
    newTapa01.path_imagen = @"1.jpg";
    newTapa01.rating = @(5.0);
    Local *newLocal01 = [Local MR_createInContext:context];
    newLocal01.nombre = @"Bar Bosch";
    newLocal01.latitud = @(39.5716);
    newLocal01.longitud = @(2.64698);
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[newLocal01.latitud doubleValue] longitude:[newLocal01.longitud doubleValue]];
    newLocal01.distancia = [NSNumber numberWithDouble:[locationManager.locationManager.location distanceFromLocation:location]];
    newLocal01.calle = @"Plaza de las Tortugas";
    newLocal01.path_imagen = @"1.jpg";
    newLocal01.zip = @(07002);
    newLocal01.tapas = [NSSet setWithObject:newTapa01];
    newTapa01.local = newLocal01;
    
    Comentario *comentario = nil;
    for (int i = 0; i < 12; i++) {
        comentario = [Comentario MR_createEntity];
        comentario.autor = (i % 2 == 0) ? @"Frankee" : @"Alvaro";
        comentario.texto = @"Lorem ipsum dolor sit amet";
        comentario.fecha = [NSDate new];
        comentario.local = newLocal01;
    }
    
    Tapa *newTapa02 = [Tapa MR_createInContext:context];
    newTapa02.nombre = @"Pincho de tortilla";
    newTapa02.path_imagen = @"2.jpg";
    newTapa02.rating = @(3.5);
    Local *newLocal02 = [Local MR_createInContext:context];
    newLocal02.nombre = @"Bar Las Palmas";
    newLocal02.latitud = @(39.569711);
    newLocal02.longitud = @(2.6607389);
    location = [[CLLocation alloc] initWithLatitude:[newLocal02.latitud doubleValue] longitude:[newLocal02.longitud doubleValue]];
    newLocal02.distancia = [NSNumber numberWithDouble:[locationManager.locationManager.location distanceFromLocation:location]];
    newLocal02.calle = @"Foners";
    newLocal02.path_imagen = @"1.jpg";
    newLocal02.zip = @(07006);
    newLocal02.tapas = [NSSet setWithObject:newTapa02];
    newTapa02.local = newLocal02;
    
    Tapa *newTapa03 = [Tapa MR_createInContext:context];
    newTapa03.nombre = @"Morcilla";
    newTapa03.path_imagen = @"3.jpg";
    newTapa03.rating = @(4.5);
    Local *newLocal03 = [Local MR_createInContext:context];
    newLocal03.nombre = @"El rincón Rociero";
    newLocal03.latitud = @(39.5873309);
    newLocal03.longitud = @(2.6623928000000205);
    location = [[CLLocation alloc] initWithLatitude:[newLocal03.latitud doubleValue] longitude:[newLocal03.longitud doubleValue]];
    newLocal03.distancia = [NSNumber numberWithDouble:[locationManager.locationManager.location distanceFromLocation:location]];
    newLocal03.calle = @"Fuera";
    newLocal03.path_imagen = @"1.jpg";
    newLocal03.zip = @(07002);
    newLocal03.tapas = [NSSet setWithObject:newTapa03];
    newTapa03.local = newLocal03;
    
    Tapa *newTapa04 = [Tapa MR_createInContext:context];
    newTapa04.nombre = @"Calamares";
    newTapa04.path_imagen = @"4.jpg";
    newTapa04.rating = @(4.5);
    Local *newLocal04 = [Local MR_createInContext:context];
    newLocal04.nombre = @"La Bodega de las Ramblas";
    newLocal04.latitud = @(39.5731427);
    newLocal04.longitud = @(2.6495568);
    location = [[CLLocation alloc] initWithLatitude:[newLocal04.latitud doubleValue] longitude:[newLocal04.longitud doubleValue]];
    newLocal04.distancia = [NSNumber numberWithDouble:[locationManager.locationManager.location distanceFromLocation:location]];
    newLocal04.calle = @"Las Ramblas";
    newLocal04.path_imagen = @"1.jpg";
    newLocal04.zip = @(07002);
    newLocal04.tapas = [NSSet setWithObject:newTapa04];
    newTapa04.local = newLocal04;
    
    Tapa *newTapa05 = [Tapa MR_createInContext:context];
    newTapa05.nombre = @"Queso con arándanos";
    newTapa05.path_imagen = @"4.jpg";
    newTapa05.rating = @(4.5);
    Local *newLocal05 = [Local MR_createInContext:context];
    newLocal05.nombre = @"100 Montaditos";
    newLocal05.latitud = @(39.573745);
    newLocal05.longitud = @(2.6526859000000513);
    location = [[CLLocation alloc] initWithLatitude:[newLocal05.latitud doubleValue] longitude:[newLocal05.longitud doubleValue]];
    newLocal05.distancia = [NSNumber numberWithDouble:[locationManager.locationManager.location distanceFromLocation:location]];
    newLocal05.calle = @"Plaza España";
    newLocal05.path_imagen = @"1.jpg";
    newLocal05.zip = @(07002);
    newLocal05.tapas = [NSSet setWithObject:newTapa05];
    newTapa05.local = newLocal05;
    
    NSError *error;
    [[NSManagedObjectContext MR_contextForCurrentThread] save:&error];
    if (error) {
        NSLog(@"Error saving %@", [error description]);
    }
}

@end
