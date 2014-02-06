//
//  User.h
//  Tapapp
//
//  Created by Álvaro on 06/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * path_imagen;
@property (nonatomic, retain) NSNumber * comments;
@property (nonatomic, retain) NSNumber * favoritos;
@property (nonatomic, retain) NSNumber * checkins;
@property (nonatomic, retain) NSNumber * identifier;

@end