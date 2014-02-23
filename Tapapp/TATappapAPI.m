//
//  TATappapAPI.m
//  Tapapp
//
//  Created by Álvaro on 02/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "TATappapAPI.h"

NSString * const TAAPIURL = @"http://tapapp.com/";

@implementation TATappapAPI

+ (instancetype)sharedInstance
{
    static TATappapAPI *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TATappapAPI alloc] initWithBaseURL:[NSURL URLWithString:TAAPIURL]];
    });
    return sharedInstance;
}

#pragma mark - Basic HTTP authorization

- (void)setBasicAuthorizationWithUsername:(NSString *)username
                                 password:(NSString *)password
{
    [self setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [self.requestSerializer clearAuthorizationHeader];
    [self.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
}

#pragma mark - Login & register

- (void)registerWithEmail:(NSString *)email
                 password:(NSString *)password
                 username:(NSString *)username
                     name:(NSString *)name
                    image:(UIImage *)image
          completionBlock:(TATapappCompletionBlock)completionBlock
{
    NSDictionary *parameters = @{@"email"       : email,
                                 @"password"    : password,
                                 @"username"    : username,
                                 @"nombre"      : name};
    [self POST:@"/user" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
        [formData appendPartWithFileData:imageData name:@"imagen" fileName:@"imagen" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@ %@", [responseObject class], responseObject);
        NSString *username = responseObject[@"data"][@"username"];
        [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
        [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
        [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"][@"id"] forKey:@"user_code"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self setBasicAuthorizationWithUsername:username password:password];
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            User *selfUser = [User MR_createInContext:localContext];
            NSDictionary *user = [responseObject objectForKey:@"data"];
            selfUser.identifier = [NSNumber numberWithInteger:[user[@"id"] integerValue]];
            selfUser.nombre = user[@"nombre"];
            selfUser.username = user[@"username"];
            selfUser.path_imagen = user[@"imagen"];
            selfUser.checkins = [NSNumber numberWithInteger:[user[@"numero_checkins"] integerValue]];
            selfUser.comments = [NSNumber numberWithInteger:[user[@"numero_comentarios"] integerValue]];
            selfUser.favoritos = [NSNumber numberWithInteger:[user[@"numero_favoritos"] integerValue]];
        } completion:^(BOOL success, NSError *error) {
            if (completionBlock) {
                completionBlock(responseObject);
            }
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"<%@> : %@ : ERROR %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error);
    }];
}

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
          completionBlock:(TATapappCompletionBlock)completionBlock
{
    [self setBasicAuthorizationWithUsername:username password:password];
    [self POST:@"/user/check/credential" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@ %@", [responseObject class], responseObject);
        NSString *username = responseObject[@"data"][@"username"];
        [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
        [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
        [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"][@"id"] forKey:@"user_code"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self setBasicAuthorizationWithUsername:username password:password];
        if (completionBlock) {
            completionBlock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"<%@> : %@ : ERROR %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error);
    }];
}

#pragma mark - Locals

- (void)listNearLocalsWithinLocation:(CLLocationCoordinate2D)coordinate
                     completionBlock:(TATapappCompletionBlock)completionBlock
{
    NSDictionary *parameters = @{@"latitud"     : @(coordinate.latitude),
                                 @"longitud"    : @(coordinate.longitude),
                                 @"distancia"   : @(5000)};
    [self GET:@"/local/near" parameters:parameters resultClass:MTLLocal.class resultKeyPath:@"data.data" completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        [TAPrivateMOC backgroundSaveWithBlock:^(NSManagedObjectContext *privateContext) {
            for (MTLLocal *local in responseObject) {
                NSError *error = nil;
                Local *localObj = [MTLManagedObjectAdapter managedObjectFromModel:local
                                                             insertingIntoContext:privateContext
                                                                            error:&error];
                if (error) {
                    NSLog(@"error creating MTLManagedObjectAdapter %@", error);
                }
                CLLocation *location = [[CLLocation alloc] initWithLatitude:[localObj.latitud doubleValue] longitude:[localObj.longitud doubleValue]];
                localObj.distancia = @([[TALocationManager sharedInstance].lastLocation distanceFromLocation:location]);
            }
        } completion:^(BOOL success, NSError *error) {
            if (!success) {
                NSLog(@"error saving locals %@", error);
            }
            if (completionBlock) {
                completionBlock(responseObject);
            }
        }];
    }];
}

- (void)postLocalWithLocal:(NSDictionary *)local
                     image:(UIImage *)image
           completionBlock:(TATapappCompletionBlock)completionBlock
{
    [self POST:@"/local" parameters:local resultClass:MTLLocal.class resultKeyPath:@"data" constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
        [formData appendPartWithFileData:imageData name:@"imagen" fileName:@"imagen" mimeType:@"image/jpeg"];
    } completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        NSLog(@"local response %@", responseObject);
        MTLLocal *local = (MTLLocal *)responseObject;
        [TAPrivateMOC backgroundSaveWithBlock:^(NSManagedObjectContext *privateContext) {
            [MTLManagedObjectAdapter managedObjectFromModel:local insertingIntoContext:privateContext error:nil];
        } completion:^(BOOL success, NSError *error) {
            if (completionBlock) {
                completionBlock(responseObject);
            }
        }];
    }];
}

- (void)checkinLocal:(MTLLocal *)local
     completionBlock:(TATapappCompletionBlock)completionBlock
{
    NSString *route = [NSString stringWithFormat:@"/local/%d/checkin", [local.identifier integerValue]];
    [self POST:route parameters:nil resultClass:MTLLocal.class resultKeyPath:@"data" completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", [error localizedDescription]]];
            return;
        }
        MTLLocal *localCheckIn = (MTLLocal *)responseObject;
        NSLog(@"checkin response %@", responseObject);
        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"Te tenemos en %@", localCheckIn.nombre]];
        if (completionBlock) {
            completionBlock(responseObject);
        }
    }];
}

#pragma mark - User

- (void)getSelfUserWithCompletionBlock:(TATapappCompletionBlock)completionBlock
{
    NSString *route = [NSString stringWithFormat:@"/user"];
    [self GET:route parameters:nil resultClass:MTLUser.class resultKeyPath:@"data" completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        NSLog(@"User %@ %@", [responseObject class], responseObject);
        MTLUser *mtlUser = (MTLUser *)responseObject;
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            NSError *errorMantle = nil;
            User *user = [MTLManagedObjectAdapter managedObjectFromModel:mtlUser insertingIntoContext:localContext error:&errorMantle];
            NSLog(@"user %@", user);
        } completion:^(BOOL success, NSError *error) {
            //
        }];
    }];
}

- (void)getUserWithCode:(NSInteger)code
        completionBlock:(TATapappCompletionBlock)completionBlock
{
    NSString *route = [NSString stringWithFormat:@"/user/%d", code];
    [self GET:route parameters:nil resultClass:MTLUser.class resultKeyPath:@"data" completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        NSLog(@"User %@ %@", [responseObject class], responseObject);
        
    }];
}

@end
