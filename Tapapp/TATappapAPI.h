//
//  TATappapAPI.h
//  Tapapp
//
//  Created by Álvaro on 02/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "User.h"
#import "AFHTTPSessionManager.h"

typedef void (^TATapappCompletionBlock)(id response);

@interface TATappapAPI : AFHTTPSessionManager

+ (instancetype)sharedInstance;

- (void)setBasicAuthorizationWithUsername:(NSString *)username
                                 password:(NSString *)password;

#pragma mark - Login y registro

- (void)registerWithEmail:(NSString *)email
                 password:(NSString *)password
                 username:(NSString *)username
                     name:(NSString *)name
                    image:(UIImage *)image
          completionBlock:(TATapappCompletionBlock)completionBlock;
- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
          completionBlock:(TATapappCompletionBlock)completionBlock;

#pragma mark - Locals

- (void)listNearLocalsWithinLocation:(CLLocationCoordinate2D)coordinate
                     completionBlock:(TATapappCompletionBlock)completionBlock;

@end
