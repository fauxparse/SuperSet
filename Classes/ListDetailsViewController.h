//
//  ListDetailsViewController.h
//  SuperSet
//
//  Created by Matt Powell on 18/08/10.
//  Copyright 2010 Matt Powell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetList.h"
#import "CellOwner.h"
#import "EditableTableCell.h"

@protocol ListDetailsDelegate;

@interface ListDetailsViewController : UIViewController <UITextFieldDelegate> {
  IBOutlet UITableView *tableView;
  IBOutlet UIDatePicker *datePicker;
  IBOutlet CellOwner *cellOwner;
  
  SetList *setList;
  id <ListDetailsDelegate> delegate;
  
@private
  NSManagedObjectContext *managedObjectContext_;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, retain) IBOutlet CellOwner *cellOwner;
@property (nonatomic, retain) SetList *setList;
@property (nonatomic, assign) id <ListDetailsDelegate> delegate;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)save;
- (void)cancel;

@end

@protocol ListDetailsDelegate <NSObject>
- (void)listDetailsViewController:(ListDetailsViewController *)listDetailsViewController didEditSetList:(SetList *)setList;
@end