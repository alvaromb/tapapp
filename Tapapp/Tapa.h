//
//  Tapa.h
//  Tapapp
//
//  Created by Álvaro on 09/12/13.
//  Copyright (c) 2013 Álvaro Medina Ballester. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Local, TipoTapa;

@interface Tapa : NSManagedObject

@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * path_imagen;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) TipoTapa *tipo;
@property (nonatomic, retain) Local *local;

@end
