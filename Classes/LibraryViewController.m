//
//  LibraryViewController.m
//  SuperSet
//
//  Created by Matt Powell on 18/08/10.
//  Copyright 2010 Matt Powell. All rights reserved.
//

#import "LibraryViewController.h"
#import "ItemDetailsViewController.h"
#import "Item.h"
#import "CheckableTableCell.h"

@implementation LibraryViewController

@synthesize setList;
@synthesize tableView;
@synthesize delegate;
@synthesize fetchedResultsController=fetchedResultsController_, managedObjectContext=managedObjectContext_;
@synthesize cellOwner;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [tableView reloadData];
}

- (void)viewDidLoad {
  self.navigationItem.title = @"Library";
  
  UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem)];
  self.navigationItem.leftBarButtonItem = addButtonItem;
  [addButtonItem release];

  UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeLibrary)];
  self.navigationItem.rightBarButtonItem = doneButtonItem;
  [doneButtonItem release];
}

- (void)configureCell:(CheckableTableCell *)cell atIndexPath:(NSIndexPath *)indexPath {
  Item *item = (Item *)[self.fetchedResultsController objectAtIndexPath:indexPath];
  NSInteger count;
  
  cell.titleLabel.text = [item valueForKey:@"title"];
  cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.descriptionLabel.text = [item tagDescription];

  if (setList) {
    count = [self.setList countOf:item];
    cell.checked = count > 0;
    NSString *countLabel = count > 1 ? [NSString stringWithFormat:@"%d", count] : @"";
//    [countLabel autorelease];
    cell.countLabel.text = countLabel;
  }
}

- (IBAction) addNewItem {
  ItemDetailsViewController *detailsController = [[ItemDetailsViewController alloc] initWithNibName:@"ItemDetailsViewController" bundle:nil];
  detailsController.delegate = self;
  detailsController.managedObjectContext = self.managedObjectContext;
  
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:detailsController];
  navigationController.navigationBar.barStyle = UIBarStyleBlack;
  [self presentModalViewController:navigationController animated:YES];
  [navigationController release];
  [detailsController release];
}

- (IBAction) closeLibrary {
  [self.delegate libraryViewController:self addedItems:nil];
}

- (void)itemDetailsViewController:(ItemDetailsViewController *)itemDetailsViewController didEditItem:(Item *)item wasNew:(BOOL)wasNew {
  if (wasNew) {
    [self dismissModalViewControllerAnimated:YES];
  } else {
    [self.navigationController popViewControllerAnimated:YES];
  }
  [self.tableView reloadData];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
  return [sectionInfo numberOfObjects];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"CheckableTableCell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    [cellOwner loadMyNibFile:CellIdentifier];
    cell = (EditableTableCell *) cellOwner.cell;
  }
  
  [self configureCell:cell atIndexPath:indexPath];
  
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    // Delete the managed object for the given index path
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
      /*
       Replace this implementation with code to handle the error appropriately.
       
       abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
       */
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }
  }   
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  id <NSFetchedResultsSectionInfo> theSection = [[self.fetchedResultsController sections] objectAtIndex:section];
  return [theSection name];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString*)searchString {
  [NSFetchedResultsController deleteCacheWithName:@"Library"];
  NSPredicate *predicate = nil;
  if (searchString && [searchString length]) {
    predicate = [NSPredicate predicateWithFormat:@"title contains[cd] %@", searchString];
  } else {
    predicate = [NSPredicate predicateWithValue:YES];
  }
  [self.fetchedResultsController.fetchRequest setPredicate:predicate];
  
  NSError *error = nil;
  if (![[self fetchedResultsController] performFetch:&error]) {
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }           
  
  return YES;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  Item *item = (Item *)[self.fetchedResultsController objectAtIndexPath:indexPath];
  SetListItem *newItem;
  
  if (setList) {
    newItem = (SetListItem *)[SetListItem insertInManagedObjectContext:self.managedObjectContext];
    newItem.item = item;
    newItem.position = [NSNumber numberWithInteger:[[setList sortedItems] count]];
    [setList addSetListItem:newItem];
    [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
    NSError *error = nil;
    if (![newItem.managedObjectContext save:&error]) {
      /*
       Replace this implementation with code to handle the error appropriately.
       abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
       */
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }
  }
  
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
  ItemDetailsViewController *detailsController = [[ItemDetailsViewController alloc] initWithNibName:@"ItemDetailsViewController" bundle:nil];
  detailsController.delegate = self;
  detailsController.managedObjectContext = self.managedObjectContext;
  detailsController.item = (Item *)[self.fetchedResultsController objectAtIndexPath:indexPath];
  [self.navigationController pushViewController:detailsController animated:YES];
}

#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
  if (fetchedResultsController_ != nil) {
    return fetchedResultsController_;
  }
  
  /*
   Set up the fetched results controller.
   */
  // Create the fetch request for the entity.
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  // Edit the entity name as appropriate.
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"Item" inManagedObjectContext:self.managedObjectContext];
  [fetchRequest setEntity:entity];
  
  // Set the batch size to a suitable number.
  [fetchRequest setFetchBatchSize:20];
  
  // Edit the sort key as appropriate.
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
  NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
  
  [fetchRequest setSortDescriptors:sortDescriptors];
  
  // Edit the section name key path and cache name if appropriate.
  // nil for section name key path means "no sections".
  NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"firstLetter" cacheName:@"Library"];
  aFetchedResultsController.delegate = self;
  self.fetchedResultsController = aFetchedResultsController;
  
  [aFetchedResultsController release];
  [fetchRequest release];
  [sortDescriptor release];
  [sortDescriptors release];
  
  NSError *error = nil;
  if (![fetchedResultsController_ performFetch:&error]) {
    /*
     Replace this implementation with code to handle the error appropriately.
     
     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
     */
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }
  
  return fetchedResultsController_;
}    

#pragma mark -
#pragma mark Fetched results controller delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
  [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
  
  switch(type) {
    case NSFetchedResultsChangeInsert:
      [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeDelete:
      [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
      break;
  }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
  UITableView *tableView = self.tableView;
  
  switch(type) {
      
    case NSFetchedResultsChangeInsert:
      [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeDelete:
      [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeUpdate:
      [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
      break;
      
    case NSFetchedResultsChangeMove:
      [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
      [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
      break;
  }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
  [self.tableView endUpdates];
}

/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
  // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
  // For example: self.myOutlet = nil;
}

- (void)dealloc {
  [cellOwner release];
  [fetchedResultsController_ release];
  [managedObjectContext_ release];
  [setList release];
  [tableView release];
  [super dealloc];
}

@end

