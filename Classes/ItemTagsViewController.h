//
//  ItemTagsViewController.h
//  ListN
//
//  Created by Matt Powell on 19/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Item.h"
#import "Tag.h"

@interface ItemTagsViewController : UIViewController <NSFetchedResultsControllerDelegate, UITextFieldDelegate> {
  Item *item;
  NSMutableSet *tags;
  IBOutlet UITableView *tableView;
  IBOutlet UITextField *newTag;
  IBOutlet UIBarButtonItem *addTag;
  
@private
  NSFetchedResultsController *fetchedResultsController_;
  NSManagedObjectContext *managedObjectContext_;
}

- (IBAction) add;
- (IBAction) tagChanged;

@property (nonatomic, retain) Item *item;
@property (nonatomic, retain) NSMutableSet *tags;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UITextField *newTag;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *addTag;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end
