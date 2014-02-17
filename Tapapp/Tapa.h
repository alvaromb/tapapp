//
//  Tapa.h
//  Tapapp
//
//  Created by Álvaro on 17/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Local, TipoTapa;

@interface Tapa : NSManagedObject

@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * path_imagen;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSDate * fechaCreacion;
@property (nonatomic, retain) Local *local;
@property (nonatomic, retain) TipoTapa *tipo;

@end
