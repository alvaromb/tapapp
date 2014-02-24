//
//  MTLComentario.m
//  Tapapp
//
//  Created by Álvaro on 18/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "MTLComentario.h"

@implementation MTLComentario

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier"  : @"id",
             @"texto"       : @"comentario",
             @"fecha"       : @"fecha"};
}

+ (NSValueTransformer *)fechaJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *str) {
        if (!str) return nil;
        return [[self dateFormatter] dateFromString:str];
    } reverseBlock:^id(NSDate *date) {
        if (!date) return nil;
        return [[self dateFormatter] stringFromDate:date];
    }];
}

#pragma mark - MTLManagedObjectSerializing

+ (NSString *)managedObjectEntityName
{
    return @"Comentario";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey
{
    return @{@"identifier"  : @"identifier",
             @"texto"       : @"texto"};
}

+ (NSValueTransformer *)fechaEntityAttributeTransformer
{
    return [[self fechaJSONTransformer] mtl_invertedTransformer];
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
