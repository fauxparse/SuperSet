//
//  ItemDetailsViewController.m
//  ListN
//
//  Created by Matt Powell on 18/08/10.
//  Copyright 2010 Matt Powell. All rights reserved.
//

#import "ItemDetailsViewController.h"
#import "ItemTagsViewController.h"
#import "RootViewController.h"

@implementation ItemDetailsViewController

@synthesize tableView;
@synthesize cellOwner;
@synthesize delegate;
@synthesize item;
@synthesize title;
@synthesize tags;
@synthesize managedObjectContext=managedObjectContext_;

#define ITEM_TITLE_SECTION 0
#define ITEM_TAGS_SECTION 1

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];

  self.navigationItem.title = @"Item Details";

  UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
  self.navigationItem.leftBarButtonItem = cancelButtonItem;
  [cancelButtonItem release];
  
  UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
  self.navigationItem.rightBarButtonItem = saveButtonItem;
  [saveButtonItem release];
  
  if (item) {
    self.tags = [[NSMutableSet alloc] initWithSet:item.tags];
    self.title = [[NSMutableString alloc] initWithString:item.title];
  } else {
    self.tags = [[NSMutableSet alloc] initWithCapacity:3];
    self.title = [[NSMutableString alloc] initWithString:@""];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [tableView reloadData];
  [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  EditableTableCell *cell = (EditableTableCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:ITEM_TITLE_SECTION]];
  [self.title setString:cell.textField.text];
  [super viewWillDisappear:animated];
}

- (void)save {
  // TODO: don't allow blank titles!
  if (!item) {
    self.item = (Item *)[Item insertInManagedObjectContext:self.managedObjectContext];
  }
  
  EditableTableCell *cell;
  cell = (EditableTableCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:ITEM_TITLE_SECTION]];
  item.title = cell.textField.text;
	
  NSError *error = nil;
	if (![item.managedObjectContext save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}

  [item setTags:[self tags]];
	[self.delegate itemDetailsViewController:self didEditItem:item];
}

- (void)cancel {
	[self.delegate itemDetailsViewController:self didEditItem:nil];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  // Return the number of sections.
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  switch (section) {
    case ITEM_TAGS_SECTION:
      return 1;
    case ITEM_TITLE_SECTION:
    default:
      return 1;
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == ITEM_TAGS_SECTION) {
    int i = [tags count];
    return i < 1 ? 44 : i * 32;
  } else {
    return 44;
  }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == ITEM_TITLE_SECTION) {
    static NSString *CellIdentifier = @"EditableTableCell";
    EditableTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
      [cellOwner loadMyNibFile:CellIdentifier];
      cell = (EditableTableCell *) cellOwner.cell;
    }
    cell.textField.placeholder = @"Title";
    cell.textField.text = self.title;
    cell.textField.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
  } else if (indexPath.section == ITEM_TAGS_SECTION) {
    static NSString *CellIdentifier = @"Tag";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if ([tags count]) {
      NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
      NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
      NSArray *tagNames = [[NSArray alloc] initWithArray:[self.tags sortedArrayUsingDescriptors:sortDescriptors]];
      [sortDescriptors dealloc];
      [sortDescriptor dealloc];
      
      cell.textLabel.text = [tagNames componentsJoinedByString:@"\n"];
      cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
      cell.textLabel.numberOfLines = [tagNames count];
    } else {
      cell.textLabel.text = @"Add tags";
      cell.textLabel.numberOfLines = 1;
    }
    return cell;
  } else {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    return cell;
  }
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
  if ([cell isKindOfClass:[EditableTableCell class]]) {
    [[cell textField] becomeFirstResponder];
  } else if (indexPath.section == ITEM_TAGS_SECTION) {
    ItemTagsViewController *detailViewController = [[ItemTagsViewController alloc] initWithNibName:@"ItemTagsViewController" bundle:nil];
    detailViewController.item = self.item;
    detailViewController.tags = self.tags;
    detailViewController.managedObjectContext = [self managedObjectContext];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
  }
}

#pragma mark -
#pragma mark Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
  [self.title setString:textField.text];
	return YES;
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
//  [item release];
  [tags dealloc];
  [title dealloc];
  [managedObjectContext_ release];
  [cellOwner release];
  [tableView release];
  [super dealloc];
}

@end

