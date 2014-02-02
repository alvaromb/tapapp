//
//  TATappapAPI.h
//  Tapapp
//
//  Created by Álvaro on 02/02/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface TATappapAPI : AFHTTPSessionManager

+ (instancetype)sharedInstance;

- (void)setBasicAuthorizationWithUsername:(NSString *)username
                                 password:(NSString *)password;

@end
