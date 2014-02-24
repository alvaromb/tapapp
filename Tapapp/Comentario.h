//
//  Comentario.h
//  Tapapp
//
//  Created by Álvaro on 24/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Local;

@interface Comentario : NSManagedObject

@property (nonatomic, retain) NSString * autor;
@property (nonatomic, retain) NSDate * fecha;
@property (nonatomic, retain) NSString * texto;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) Local *local;

@end
