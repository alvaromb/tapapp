//
//  TACercaViewController.h
//  Tapapp
//
//  Created by alvaro on 25/11/13.
//  Copyright (c) 2013 alvaromb. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "TATapaMapper.h"
#import "TALocalMapper.h"
#import "TABaseViewController.h"
#import "TALocalCercaCell.h"
#import "TAInfoLocalViewController.h"

@interface TACercaViewController : TABaseViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, MKMapViewDelegate>

@end
