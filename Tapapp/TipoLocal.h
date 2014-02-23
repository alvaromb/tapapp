//
//  TipoLocal.h
//  Tapapp
//
//  Created by Álvaro on 23/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Local;

@interface TipoLocal : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * tipo;
@property (nonatomic, retain) NSSet *locales;
@end

@interface TipoLocal (CoreDataGeneratedAccessors)

- (void)addLocalesObject:(Local *)value;
- (void)removeLocalesObject:(Local *)value;
- (void)addLocales:(NSSet *)values;
- (void)removeLocales:(NSSet *)values;

@end
