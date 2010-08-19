//
//  ListItemsViewController.h
//  ListN
//
//  Created by Matt Powell on 18/08/10.
//  Copyright 2010 Matt Powell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetList.h"
#import "SetListItem.h"
#import "ListDetailsViewController.h"
#import "LibraryViewController.h"

@interface ListItemsViewController : UIViewController <ListDetailsDelegate, LibraryViewDelegate> {
  IBOutlet UITableView *tableView;

@private
  SetList *setList;
  NSManagedObjectContext *managedObjectContext_;
}

- (IBAction) addItems;
- (IBAction) showDetails;

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) SetList *setList;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
