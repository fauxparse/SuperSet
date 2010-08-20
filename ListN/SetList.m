#import "SetList.h"
#import "SetListItem.h"

@implementation SetList

@synthesize sortedItems_;

- (NSInteger) countOf:(Item *)item {
  NSInteger c = 0;
  for (SetListItem *sli in self.setListItems) {
    if ([[sli item] objectID] == [item objectID]) {
      c++;
    }
  }
  return c;
}

-(NSMutableArray*)sortedItems {
  NSSortDescriptor *sortDescriptor;
  NSArray *sortDescriptors;
  
  if (!self.sortedItems_) {
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"position" ascending:YES];
    sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    self.sortedItems_ = [[NSMutableArray alloc] initWithArray:[self.setListItems sortedArrayUsingDescriptors:sortDescriptors]];
    [sortDescriptors dealloc];
    [sortDescriptor dealloc];
  }
  return self.sortedItems_;
}

-(void)moveItemFromRow:(NSUInteger)fromRow toRow:(NSUInteger)toRow {
  NSMutableArray *items = self.sortedItems;
  
  [items exchangeObjectAtIndex:fromRow withObjectAtIndex:toRow];
  [[items objectAtIndex:toRow] updatePosition:toRow];
  if (fromRow < toRow) {
    for (NSUInteger i = fromRow; i < toRow - 1; i++) {
      [items exchangeObjectAtIndex:i withObjectAtIndex:i+1];
      [[items objectAtIndex:i] updatePosition:i];
    }
  } else if (fromRow > toRow) {
    for (NSUInteger i = fromRow; i > toRow + 1; i--) {
      [items exchangeObjectAtIndex:i withObjectAtIndex:i-1];
      [[items objectAtIndex:i] updatePosition:i];
    }
    [[items objectAtIndex:toRow+1] updatePosition:toRow+1];
  }
}

-(void)deleteItemAtIndex:(NSUInteger)index {
  NSArray *items = [[NSArray alloc] initWithArray:self.sortedItems];
  for (int i = index + 1; i < [items count]; i++) {
    [[items objectAtIndex:i] updatePosition:i-1];
  }
  [items dealloc];

  SetListItem *item = (SetListItem *)[[self sortedItems] objectAtIndex:index];
  [[self sortedItems] removeObject:item];
  [self removeSetListItemsObject:item];
//  [item release];
}

- (void)addSetListItem:(SetListItem *)item {
  [item updatePosition:[[self sortedItems] count]];
  [self addSetListItemsObject:item];
  [[self sortedItems] addObject:item];
}

- (void)dealloc {
  [[self sortedItems_] dealloc];
  [super dealloc];
}

@end
