//
//  AddItemsViewController.h
//  ListN
//
//  Created by Matt Powell on 18/08/10.
//  Copyright 2010 Matt Powell. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddItemsViewController : UIViewController {
  IBOutlet UITableView *tableView;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
