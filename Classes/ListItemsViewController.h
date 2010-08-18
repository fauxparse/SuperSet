//
//  ListItemsViewController.h
//  ListN
//
//  Created by Matt Powell on 18/08/10.
//  Copyright 2010 Matt Powell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetList.h"
#import "ListDetailsViewController.h"

@interface ListItemsViewController : UIViewController <ListDetailsDelegate> {
  IBOutlet UITableView *tableView;

@private
  SetList *setList;
}

- (IBAction) addItems;
- (IBAction) showDetails;

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) SetList *setList;

@end
