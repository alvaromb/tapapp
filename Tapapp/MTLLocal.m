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
             @"path_imagen" : @"imagen",
             @"zip"         : @"codigo_postal"};
}

+ (NSString *)managedObjectEntityName
{
    return @"Local";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey
{
    return @{};
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

+ (NSSet *)propertyKeysForManagedObjectUniquing
{
    return [NSSet setWithObject:@"identifier"];
}

+ (NSValueTransformer *)tapasJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:MTLTapa.class];
}

+ (NSValueTransformer *)tapasEntityAttributeTransformer
{
    return [[self tapasJSONTransformer] mtl_invertedTransformer];
}

+ (NSValueTransformer *)comentariosJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:MTLComentario.class];
}

+ (NSValueTransformer *)comentariosEntityAttributeTransformer
{
    return [[self comentariosJSONTransformer] mtl_invertedTransformer];
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey
{
    return @{@"tapas"       : MTLTapa.class,
             @"comentarios" : MTLComentario.class};
}

@end
