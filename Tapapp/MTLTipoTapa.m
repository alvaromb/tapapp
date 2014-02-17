//
//  MTLTipoTapa.m
//  Tapapp
//
//  Created by Álvaro on 17/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "MTLTipoTapa.h"

@implementation MTLTipoTapa

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier" : @"id"};
}

#pragma mark - MTLManagedObjectSerializing

+ (NSString *)managedObjectEntityName
{
    return @"TipoTapa";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey
{
    return @{};
}

+ (NSSet *)propertyKeysForManagedObjectUniquing
{
    return [NSSet setWithObject:@"identifier"];
}

@end
