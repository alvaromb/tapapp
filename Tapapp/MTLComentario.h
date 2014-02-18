//
//  MTLComentario.h
//  Tapapp
//
//  Created by Álvaro on 18/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "MTLModel.h"

@interface MTLComentario : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, copy, readonly) NSNumber *identifier;
@property (nonatomic, copy, readonly) NSString *texto;
@property (nonatomic, copy, readonly) NSString *autor;
@property (nonatomic, copy, readonly) NSDate *fecha;

@end
