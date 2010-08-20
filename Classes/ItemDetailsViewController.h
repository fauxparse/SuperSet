//
//  ItemDetailsViewController.h
//  ListN
//
//  Created by Matt Powell on 18/08/10.
//  Copyright 2010 Matt Powell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetListItem.h"
#import "Item.h"
#import "CellOwner.h"
#import "EditableTableCell.h"

@protocol ItemDetailsDelegate;

@interface ItemDetailsViewController : UIViewController <UITextFieldDelegate> {
  IBOutlet UITableView *tableView;
  IBOutlet CellOwner *cellOwner;
  
  Item *item;
  NSMutableSet *tags;
  NSMutableString *itemTitle;
  id <ItemDetailsDelegate> delegate;
  
@private
  NSManagedObjectContext *managedObjectContext_;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet CellOwner *cellOwner;
@property (nonatomic, retain) Item *item;
@property (nonatomic, retain) NSMutableSet *tags;
@property (nonatomic, retain) NSMutableString *itemTitle;
@property (nonatomic, assign) id <ItemDetailsDelegate> delegate;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)save;
- (void)cancel;

@end

@protocol ItemDetailsDelegate <NSObject>
- (void)itemDetailsViewController:(ItemDetailsViewController *)itemDetailsViewController didEditItem:(Item *)item wasNew:(BOOL)wasNew;
@end