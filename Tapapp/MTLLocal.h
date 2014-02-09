//
//  Local.h
//  Tapapp
//
//  Created by Álvaro on 23/01/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Comentario, Tapa;

@interface MTLLocal : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (copy, nonatomic, readonly) NSString * calle;
@property (copy, nonatomic, readonly) NSString * descripcion;
@property (copy, nonatomic, readonly) NSNumber * distancia;
@property (copy, nonatomic, readonly) NSNumber * identifier;
@property (copy, nonatomic, readonly) NSNumber * latitud;
@property (copy, nonatomic, readonly) NSNumber * longitud;
@property (copy, nonatomic, readonly) NSString * nombre;
@property (copy, nonatomic, readonly) NSString * path_imagen;
@property (copy, nonatomic, readonly) NSNumber * zip;
//@property (copy, nonatomic, readonly) NSSet *tapas;
//@property (copy, nonatomic, readonly) NSSet *comentarios;
@end
