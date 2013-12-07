//
//  TADetailViewController.h
//  Tapapp
//
//  Created by Álvaro on 07/12/13.
//  Copyright (c) 2013 Álvaro Medina Ballester. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TADetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
