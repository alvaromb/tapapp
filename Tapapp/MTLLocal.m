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
             @"zip"         : @"codigo_postal",
             @"userFaver"   : [NSNull null]};
}

+ (NSString *)managedObjectEntityName
{
    return @"Local";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey
{
//    return @{@"userFaver" : [NSNull null]};
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

+ (NSValueTransformer *)tipoJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:MTLTipoLocal.class];
}

+ (NSValueTransformer *)tipoEntityAttributeTransformer
{
    return [[self tipoJSONTransformer] mtl_invertedTransformer];
}

+ (NSValueTransformer *)userFaverJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:MTLUser.class];
}

+ (NSValueTransformer *)userFaverEntityAttributeTransformer
{
    return [[self userFaverJSONTransformer] mtl_invertedTransformer];
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey
{
    return @{@"tapas"       : MTLTapa.class,
             @"comentarios" : MTLComentario.class,
             @"tipo"        : MTLTipoLocal.class,
             @"userFaver"   : MTLUser.class};
}

@end
