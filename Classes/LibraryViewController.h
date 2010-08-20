//
//  LibraryViewController.h
//  ListN
//
//  Created by Matt Powell on 18/08/10.
//  Copyright 2010 Matt Powell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetList.h"
#import "ItemDetailsViewController.h"

@protocol LibraryViewDelegate;

@interface LibraryViewController : UIViewController <UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, ItemDetailsDelegate> {
  IBOutlet UITableView *tableView;
  id <LibraryViewDelegate> delegate;
  SetList *setList;
  IBOutlet CellOwner *cellOwner;
  
@private
  NSFetchedResultsController *fetchedResultsController_;
  NSManagedObjectContext *managedObjectContext_;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, assign) id <LibraryViewDelegate> delegate;
@property (nonatomic, assign) SetList *setList;
@property (nonatomic, retain) IBOutlet CellOwner *cellOwner;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (IBAction) addNewItem;
- (IBAction) closeLibrary;

@end

@protocol LibraryViewDelegate <NSObject>
- (void)libraryViewController:(LibraryViewController *)libraryViewController addedItems:(SetList *)setList;
@end