//
//  MTLTipoLocal.h
//  Tapapp
//
//  Created by Álvaro on 23/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "MTLModel.h"

@interface MTLTipoLocal : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, copy) NSString *tipo;

@end
