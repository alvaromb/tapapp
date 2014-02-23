//
//  Local.h
//  Tapapp
//
//  Created by Álvaro on 23/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comentario, Tapa, TipoLocal;

@interface Local : NSManagedObject

@property (nonatomic, retain) NSString * calle;
@property (nonatomic, retain) NSString * descripcion;
@property (nonatomic, retain) NSNumber * distancia;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSNumber * latitud;
@property (nonatomic, retain) NSNumber * longitud;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * path_imagen;
@property (nonatomic, retain) NSString * zip;
@property (nonatomic, retain) NSSet *comentarios;
@property (nonatomic, retain) NSSet *tapas;
@property (nonatomic, retain) TipoLocal *tipo;
@end

@interface Local (CoreDataGeneratedAccessors)

- (void)addComentariosObject:(Comentario *)value;
- (void)removeComentariosObject:(Comentario *)value;
- (void)addComentarios:(NSSet *)values;
- (void)removeComentarios:(NSSet *)values;

- (void)addTapasObject:(Tapa *)value;
- (void)removeTapasObject:(Tapa *)value;
- (void)addTapas:(NSSet *)values;
- (void)removeTapas:(NSSet *)values;

@end
