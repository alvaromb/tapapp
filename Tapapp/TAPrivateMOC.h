//
//  TAPrivateMOC.h
//  Tapapp
//
//  Created by Álvaro on 18/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface TAPrivateMOC : NSManagedObjectContext

#pragma mark - Singleton
+ (instancetype)sharedInstance;

#pragma mark - Save methods
+ (void)backgroundSaveWithBlock:(void (^)(NSManagedObjectContext *privateContext))block;
+ (void)backgroundSaveWithBlock:(void (^)(NSManagedObjectContext *privateContext))block
                     completion:(void (^)(BOOL success, NSError *error))completion;

@end
