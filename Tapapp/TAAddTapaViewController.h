//
//  TAAddTapaViewController.h
//  Tapapp
//
//  Created by Álvaro on 25/01/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "Tapa.h"
#import "TipoTapa.h"
#import "TABaseTableViewController.h"

@interface TAAddTapaViewController : TABaseTableViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) Local *local;

@end
