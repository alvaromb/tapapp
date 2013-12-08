//
//  Tapa.h
//  Tapapp
//
//  Created by Álvaro on 08/12/13.
//  Copyright (c) 2013 Álvaro Medina Ballester. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Tapa : NSManagedObject

@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * path_imagen;
@property (nonatomic, retain) NSDecimalNumber * rating;

@end
