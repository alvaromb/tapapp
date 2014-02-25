//
//  MTLUser.m
//  Tapapp
//
//  Created by Álvaro on 16/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "MTLUser.h"

@implementation MTLUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier"      : @"id",
             @"numCheckins"     : @"numero_checkins",
             @"numComentarios"  : @"numero_comentarios",
             @"numFavoritos"    : @"numero_favoritos",
             @"favs"            : [NSNull null]};
}

+ (NSString *)managedObjectEntityName
{
    return @"User";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey
{
    return @{@"imagen"          : @"path_imagen",
             @"numCheckins"     : @"checkins",
             @"numComentarios"  : @"comments",
             @"numFavoritos"    : @"favoritos"};
}

+ (NSValueTransformer *)imagenJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *str) {
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", TAAPIURL, str]];
    } reverseBlock:^id(NSURL *url) {
        return [url absoluteString];
    }];
}

+ (NSValueTransformer *)imagenEntityAttributeTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSURL *url) {
        return [url absoluteString];
    } reverseBlock:^id(NSString *str) {
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", TAAPIURL, str]];
    }];
}

+ (NSValueTransformer *)favsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:MTLLocal.class];
}

+ (NSValueTransformer *)favsEntityAttributeTransformer
{
    return [[self favsJSONTransformer] mtl_invertedTransformer];
}

+ (NSValueTransformer *)comentariosJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:MTLComentario.class];
}

+ (NSValueTransformer *)comentariosEntityAttributeTransformer
{
    return [[self comentariosJSONTransformer] mtl_invertedTransformer];
}

+ (NSSet *)propertyKeysForManagedObjectUniquing
{
    return [NSSet setWithObject:@"identifier"];
}

@end
