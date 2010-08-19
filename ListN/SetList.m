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

-(NSArray*)sortedItems {
  NSSortDescriptor *sortDescriptor;
  NSArray *sortDescriptors;
  
  if (!self.sortedItems_) {
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"position" ascending:YES];
    sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    self.sortedItems_ = [self.setListItems sortedArrayUsingDescriptors:sortDescriptors];
  }
  return self.sortedItems_;
}

-(void)moveItemFromRow:(NSUInteger)fromRow toRow:(NSUInteger)toRow {
  NSArray *items = [[NSArray alloc] initWithArray:self.sortedItems];
  
  [[items objectAtIndex:fromRow] updatePosition:toRow];
  if (fromRow < toRow) {
    for (NSUInteger i = fromRow + 1; i <= toRow; i++) {
      [[items objectAtIndex:i] updatePosition:i-1];
    }
  } else if (toRow < fromRow) {
    for (NSUInteger i = toRow; i < fromRow; i++) {
      [[items objectAtIndex:i] updatePosition:i+1];
    }
  }
  [items dealloc];
  self.sortedItems_ = nil;
}

-(void)dealloc {
  [sortedItems_ dealloc];
  [super dealloc];
}

@end
