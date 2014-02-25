//
//  MTLUser.h
//  Tapapp
//
//  Created by Álvaro on 16/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "MTLModel.h"
#import "MTLLocal.h"

@interface MTLUser : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, copy, readonly) NSNumber *identifier;
@property (nonatomic, copy, readonly) NSString *nombre;
@property (nonatomic, copy, readonly) NSString *username;
@property (nonatomic, copy, readonly) NSURL *imagen;
@property (nonatomic, copy) NSNumber *numCheckins;
@property (nonatomic, copy) NSNumber *numComentarios;
@property (nonatomic, copy) NSNumber *numFavoritos;
@property (nonatomic, copy) NSArray *favs;
@property (nonatomic, copy, readonly) NSArray *comentarios;

@end
