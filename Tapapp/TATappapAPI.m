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
    [self.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
}

@end
