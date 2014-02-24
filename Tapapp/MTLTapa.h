//
//  MTLTapa.h
//  Tapapp
//
//  Created by Álvaro on 17/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "MTLModel.h"
#import "MTLLocal.h"
#import "MTLTipoTapa.h"

@interface MTLTapa : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, copy, readonly) NSNumber *identifier;
@property (nonatomic, copy, readonly) NSString *nombre;
@property (nonatomic, copy, readonly) NSString *desc;
@property (nonatomic, copy, readonly) NSDate *fechaCreacion;
@property (nonatomic, copy, readonly) NSURL *imagen;
@property (nonatomic, strong, readonly) MTLTipoTapa *tipoTapa;

@end
