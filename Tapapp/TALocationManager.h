//
//  TALocationManager.h
//  Tapapp
//
//  Created by Álvaro on 15/12/13.
//  Copyright (c) 2013 Álvaro Medina Ballester. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface TALocationManager : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *lastLocation;

+ (TALocationManager *)sharedInstance;
- (void)setup;

@end
