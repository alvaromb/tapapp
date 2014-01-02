//
//  TALocationManager.m
//  Tapapp
//
//  Created by Álvaro on 15/12/13.
//  Copyright (c) 2013 Álvaro Medina Ballester. All rights reserved.
//

#import "TALocationManager.h"

@implementation TALocationManager

#pragma mark - Lazy instantiation

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    }
    return _locationManager;
}


#pragma mark - Shared instance

+ (TALocationManager *)sharedInstance
{
    static TALocationManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TALocationManager alloc] init];
    });
    return instance;
}


#pragma mark - Setup methods

- (void)setup
{
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"");
        return;
    }
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    if (authStatus == kCLAuthorizationStatusRestricted) {
        NSLog(@"");
        return;
    }
    [self.locationManager startMonitoringSignificantLocationChanges];
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *lastLocation = [locations lastObject];
    NSLog(@"Location updated %@ // interval %f", lastLocation, [lastLocation.timestamp timeIntervalSinceNow]);
    if ([lastLocation.timestamp timeIntervalSinceNow] > 10) {
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"locationAvailable" object:nil];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Location error %@", error);
}

@end
