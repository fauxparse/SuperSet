//
//  RootViewController.h
//  SuperSet
//
//  Created by Matt Powell on 18/08/10.
//  Copyright Matt Powell 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LibraryViewController.h"
#import "ListDetailsViewController.h"
#import "SetList.h"

@interface RootViewController : UIViewController <ListDetailsDelegate, NSFetchedResultsControllerDelegate, LibraryViewDelegate> {
  IBOutlet UITableView *tableView;
  
@private
  NSFetchedResultsController *fetchedResultsController_;
  NSManagedObjectContext *managedObjectContext_;
}

- (IBAction) add;
- (IBAction) showLibrary;

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end
