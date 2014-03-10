//
//  TAInfoLocalViewController.h
//  Tapapp
//
//  Created by Álvaro on 04/01/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "TATapaCell.h"
#import "TATapaMapper.h"
#import "TATapaViewController.h"
#import "TAAddTapaViewController.h"
#import "TAComentariosLocalViewController.h"
#import <MapKit/MapKit.h>

@interface TAInfoLocalViewController : TABaseTableViewController

@property (strong, nonatomic) Local *local;

@end
