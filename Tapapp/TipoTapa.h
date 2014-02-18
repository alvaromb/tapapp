//
//  TipoTapa.h
//  Tapapp
//
//  Created by Álvaro on 18/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tapa;

@interface TipoTapa : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * tipo;
@property (nonatomic, retain) NSSet *tapas;
@end

@interface TipoTapa (CoreDataGeneratedAccessors)

- (void)addTapasObject:(Tapa *)value;
- (void)removeTapasObject:(Tapa *)value;
- (void)addTapas:(NSSet *)values;
- (void)removeTapas:(NSSet *)values;

@end
