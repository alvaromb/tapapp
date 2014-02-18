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
    return @{};
}

#pragma mark - MTLManagedObjectSerializing

+ (NSString *)managedObjectEntityName
{
    return @"Comentario";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey
{
    return @{};
}

@end
