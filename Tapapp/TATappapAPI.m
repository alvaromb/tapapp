//
//  TATappapAPI.m
//  Tapapp
//
//  Created by Álvaro on 02/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "TATappapAPI.h"

static NSString * const TAAPIURL = @"http://tapapp.com/";

@implementation TATappapAPI

+ (instancetype)sharedInstance
{
    static TATappapAPI *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sharedInstance = [[TATappapAPI alloc] initWithBaseURL:[NSURL URLWithString:TAAPIURL] sessionConfiguration:sessionConfiguration];
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
        NSData *imageData = UIImagePNGRepresentation(image);
        [formData appendPartWithFileData:imageData name:@"imagen" fileName:@"imagen" mimeType:@"image/png"];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
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
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"<%@> : %@ : ERROR %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error);
    }];
}

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
          completionBlock:(TATapappCompletionBlock)completionBlock
{
    [self setBasicAuthorizationWithUsername:username password:password];
    [self POST:@"/user/check/credential" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@ %@", [responseObject class], responseObject);
        NSString *username = responseObject[@"data"][@"username"];
        [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
        [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self setBasicAuthorizationWithUsername:username password:password];
        if (completionBlock) {
            completionBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"<%@> : %@ : ERROR %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error);
    }];
}

- (void)listNearLocalsWithinLocation:(CLLocationCoordinate2D)coordinate
                     completionBlock:(TATapappCompletionBlock)completionBlock
{
    NSDictionary *parameters = @{@"latitud"     : @(coordinate.latitude),
                                 @"longitud"    : @(coordinate.longitude),
                                 @"distancia"   : @(4000)};
    [self GET:@"/local/near" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        AMBLog(@"Success: %@", responseObject);
        NSLog(@"%@", responseObject);
        if (completionBlock) {
            completionBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        AMBLog(@"%@ %@", error, [error userInfo]);
    }];
}

@end
