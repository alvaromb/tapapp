//
//  TABaseTableViewController.h
//  Tapapp
//
//  Created by Álvaro on 19/01/14.
//  Copyright (c) 2014 Álvaro Medina Ballester. All rights reserved.
//

#import "TABaseFetchedViewController.h"

@interface TABaseTableViewController : TABaseFetchedViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

- (void)configureCell:(UITableViewCell *)cell
          atIndexPath:(NSIndexPath *)indexPath;

@end
