//
//  ListItemsViewController.m
//  SuperSet
//
//  Created by Matt Powell on 18/08/10.
//  Copyright 2010 Matt Powell. All rights reserved.
//

#import "ListItemsViewController.h"
#import "LibraryViewController.h"
#import "ListDetailsViewController.h"
#import "SetList.h"

@implementation ListItemsViewController

@synthesize tableView;
@synthesize setList;
@synthesize managedObjectContext=managedObjectContext_;

#pragma mark -
#pragma mark View lifecycle

- (void) viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.rightBarButtonItem = self.editButtonItem;
  self.navigationItem.title = self.setList ? self.setList.title : @"New Set List";
}

- (IBAction) addItems {
  LibraryViewController *libraryController = [[LibraryViewController alloc] initWithNibName:@"LibraryViewController" bundle:nil];
  libraryController.delegate = self;
  libraryController.setList = setList;
  libraryController.managedObjectContext = self.managedObjectContext;
  
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:libraryController];
  navigationController.navigationBar.barStyle = UIBarStyleBlack;
  [self presentModalViewController:navigationController animated:YES];
  [navigationController release];
  [libraryController release];
}

- (IBAction) showDetails {
  ListDetailsViewController *detailsController = [[ListDetailsViewController alloc] initWithNibName:@"ListDetailsViewController" bundle:nil];
  detailsController.delegate = self;
  detailsController.setList = setList;
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:detailsController];
  navigationController.navigationBar.barStyle = UIBarStyleBlack;
  [self presentModalViewController:navigationController animated:YES];
  [navigationController release];
  [detailsController release];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations.
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  return [[setList sortedItems] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  SetListItem *listItem = (SetListItem *)[self.setList.sortedItems objectAtIndex:indexPath.row];
  Item *item = [listItem item];
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
  }
    
  cell.textLabel.text = [item title];
  cell.detailTextLabel.text = [item tagDescription];
    
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [setList deleteItemAtIndex:indexPath.row];
    [tableView reloadData];
  } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
  }   
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
  [setList moveItemFromRow:fromIndexPath.row toRow:toIndexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

#pragma mark -
#pragma mark Table view delegate

- (void)setEditing:(BOOL)editing animated:(BOOL)animate {
  [super setEditing:editing animated:animate];
  [tableView setEditing:editing animated:animate];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}

- (void)listDetailsViewController:(ListDetailsViewController *)listDetailsViewController didEditSetList:(SetList *)setList {
  [self dismissModalViewControllerAnimated:YES];
  if (setList) {
    self.navigationItem.title = setList.title;
  }
}

- (void)libraryViewController:(LibraryViewController *)libraryViewController addedItems:(SetList *)setList {
  [self dismissModalViewControllerAnimated:YES];
  [self.tableView reloadData];
}

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
  [tableView release];
//  [managedObjectContext_ release];
//  [setList release];
  [super dealloc];
}

@end

