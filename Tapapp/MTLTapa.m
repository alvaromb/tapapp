//
//  MTLTapa.m
//  Tapapp
//
//  Created by Álvaro on 17/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "MTLTapa.h"

@implementation MTLTapa

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"desc"            : @"descripcion",
             @"fechaCreacion"   : @"fecha_creacion",
             @"identifier"      : @"id",
             @"tipoTapa"        : @"tipo"};
}

+ (NSValueTransformer *)tipoTapaJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:MTLTipoTapa.class];
}

+ (NSValueTransformer *)fechaCreacionJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *str) {
        if (!str) return nil;
        return [[self dateFormatter] dateFromString:str];
    } reverseBlock:^id(NSDate *date) {
        return [[self dateFormatter] stringFromDate:date];
    }];
}

+ (NSValueTransformer *)imagenJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *str) {
        if (!str) return nil;
        return [NSURL URLWithString:[TAAPIURL stringByAppendingString:str]];
    } reverseBlock:^id(NSURL *url) {
        return [url absoluteString];
    }];
}

#pragma mark - MTLManagedObjectSerializing

+ (NSDictionary *)managedObjectKeysByPropertyKey
{
    return @{@"imagen"  : @"path_imagen",
             @"tipoTapa": @"tipo"};
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey
{
    return @{@"tipoTapa" : MTLTipoTapa.class};
}

+ (NSString *)managedObjectEntityName
{
    return @"Tapa";
}

+ (NSValueTransformer *)imagenEntityAttributeTransformer
{
    return [[self fechaCreacionJSONTransformer] mtl_invertedTransformer];
}

+ (NSSet *)propertyKeysForManagedObjectUniquing
{
    return [NSSet setWithObject:@"identifier"];
}

+ (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *sDateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sDateFormatter = [[NSDateFormatter alloc] init];
        sDateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"Europe/Madrid"];
        sDateFormatter.dateFormat = @"HH:mm:ss.SSSSSS'Z'";
    });
    return sDateFormatter;
}

@end
