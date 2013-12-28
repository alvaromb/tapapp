//
//  TATapasViewController.h
//  Tapapp
//
//  Created by alvaro on 25/11/13.
//  Copyright (c) 2013 alvaromb. All rights reserved.
//

#import "TABaseViewController.h"
#import "TATapaMapper.h"
#import "TATapaCell.h"

@interface TATapasViewController : TABaseViewController <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate>

@end
