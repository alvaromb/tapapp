//
//  MTLTipoTapa.h
//  Tapapp
//
//  Created by Álvaro on 17/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "MTLModel.h"

@interface MTLTipoTapa : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, copy, readonly) NSNumber *identifier;
@property (nonatomic, copy, readonly) NSString *tipo;

@end
