//
//  Local.m
//  Tapapp
//
//  Created by Álvaro on 23/01/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "MTLLocal.h"
#import "Comentario.h"
#import "Tapa.h"


@implementation MTLLocal

#pragma mark - Mantle

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier"  : @"id",
             @"descripcion" : @"descripcion",
             @"path_imagen" : @"imagen",
             @"calle"       : @"calle",
             @"zip"         : @"codigo_postal",
             @"latitud"     : @"latitud",
             @"longitud"    : @"longitud",
             @"nombre"      : @"nombre"};
}

+ (NSString *)managedObjectEntityName
{
    return @"Local";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey
{
    return @{@"calle"       : @"calle",
             @"latitud"     : @"latitud",
             @"longitud"    : @"longitud",
             @"nombre"      : @"nombre",
             @"path_imagen" : @"path_imagen",
             @"zip"         : @"zip",
             @"identifier"  : @"identifier",
             @"descripcion" : @"descripcion",};
}

+ (NSValueTransformer *)latitudEntityAttributeTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *latString) {
        return @([latString doubleValue]);
    } reverseBlock:^(NSNumber *latNumber) {
        return latNumber;
    }];
}

+ (NSValueTransformer *)longitudEntityAttributeTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *lonString) {
        return @([lonString doubleValue]);
    } reverseBlock:^(NSNumber *lonNumber) {
        return lonNumber;
    }];
}

//+ (NSValueTransformer *)tapasEntityAttributeTransformer
//{
//    return [MTLValueTransformer reversibleTransformerWithBlock:^(NSDictionary *tapa) {
//        return @"tapa";
//    }];
//}

@end
