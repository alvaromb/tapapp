//
//  User.h
//  Tapapp
//
//  Created by Álvaro on 23/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Local;

@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * checkins;
@property (nonatomic, retain) NSNumber * comments;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * favoritos;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * path_imagen;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *favs;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addFavsObject:(Local *)value;
- (void)removeFavsObject:(Local *)value;
- (void)addFavs:(NSSet *)values;
- (void)removeFavs:(NSSet *)values;

@end
