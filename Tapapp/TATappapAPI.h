//
//  TATappapAPI.h
//  Tapapp
//
//  Created by Álvaro on 02/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "User.h"
#import "MTLLocal.h"
#import "MTLUser.h"
#import "AFHTTPSessionManager.h"
#import "TAPrivateMOC.h"

extern NSString * const TAAPIURL;

typedef void (^TATapappCompletionBlock)(id response);

@interface TATappapAPI : OVCClient

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
- (void)postLocalWithLocal:(NSDictionary *)local
                     image:(UIImage *)image
           completionBlock:(TATapappCompletionBlock)completionBlock;
- (void)checkinLocal:(MTLLocal *)local
     completionBlock:(TATapappCompletionBlock)completionBlock;
- (void)addComentario:(NSString *)comentario
             forLocal:(MTLLocal *)local
      completionBlock:(TATapappCompletionBlock)completionBlock;

#pragma mark - User
- (void)getSelfUserWithCompletionBlock:(TATapappCompletionBlock)completionBlock;
- (void)getUserWithCode:(NSInteger)code
        completionBlock:(TATapappCompletionBlock)completionBlock;

#pragma mark - Tapas
- (void)postTapa:(NSDictionary *)tapa
          imagen:(UIImage *)imagen
        forLocal:(NSManagedObjectID *)local
 completionBlock:(TATapappCompletionBlock)completionBlock;

@end
