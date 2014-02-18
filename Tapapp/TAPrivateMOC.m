//
//  TAPrivateMOC.m
//  Tapapp
//
//  Created by Álvaro on 18/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "TAPrivateMOC.h"

@implementation TAPrivateMOC

#pragma mark - Singleton

+ (instancetype)sharedInstance
{
    static TAPrivateMOC *selfInstance = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (selfInstance == NULL) {
            selfInstance = [[[self class] alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
            [selfInstance setParentContext:[NSManagedObjectContext MR_defaultContext]];
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(contextWillSave:)
                                                         name:NSManagedObjectContextWillSaveNotification
                                                       object:self];
        }
    });
    return selfInstance;
}

- (void)contextWillSave:(NSNotification *)notification
{
    NSManagedObjectContext *context = [notification object];
    NSSet *insertedObjects = [context insertedObjects];
    if ([insertedObjects count]) {
        [context obtainPermanentIDsForObjects:[insertedObjects allObjects] error:nil];
    }
}

#pragma mark - Save methods

+ (void)backgroundSaveWithBlock:(void (^)(NSManagedObjectContext *privateContext))block
{
    [self backgroundSaveWithBlock:block completion:nil];
}

+ (void)backgroundSaveWithBlock:(void (^)(NSManagedObjectContext *privateContext))block
                     completion:(void (^)(BOOL success, NSError *error))completion
{
    NSManagedObjectContext *privateContext = [self sharedInstance];
    [privateContext performBlock:^{
        NSAssert(![NSThread isMainThread], @"Trying to performBlock in privateContext in main thread");
        NSLog(@"Performing block in thread %@ / main thread %@", [NSThread currentThread], [NSThread mainThread]);
        if (block) {
            block([self sharedInstance]);
        }
        // Save parents & execute completion block in main queue
        [[self sharedInstance] MR_saveWithOptions:MRSaveParentContexts completion:^(BOOL success, NSError *error) {
            completion(success, error);
        }];
    }];
}

@end
