#import "Item.h"

@implementation Item

@synthesize tags_;

@dynamic firstLetter;

- (NSString *) firstLetter {
  return [[NSString alloc] initWithFormat:@"%c", [self.title characterAtIndex:0]];
}

- (NSMutableSet *) tags {
  if (!tags_) {
    self.tags_ = [[NSMutableSet alloc] initWithCapacity:[self.itemTags count]];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    NSArray *tagValues = [[NSArray alloc] initWithArray:[self.itemTags sortedArrayUsingDescriptors:sortDescriptors]];
    [sortDescriptors dealloc];
    [sortDescriptor dealloc];

    for (int i = 0; i < [tagValues count]; i++) {
      [self.tags_ addObject:[[tagValues objectAtIndex:i] tag]];
    }
    [tagValues release];
  }
  return tags_;
}

- (void) setTags:(NSMutableSet *)values {
  [self removeItemTags:[self tags]];
  [[self tags] removeAllObjects];
  
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
  NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
  NSArray *tagValues = [[NSArray alloc] initWithArray:[values sortedArrayUsingDescriptors:sortDescriptors]];
  [sortDescriptors dealloc];
  [sortDescriptor dealloc];

  for (int i = 0; i < [tagValues count]; i++) {
    [self addTag:[tagValues objectAtIndex:i]];
  }
}

- (BOOL) hasTag:(Tag *)tag {
  return [[self tags] containsObject:tag];
}

- (void) addTag:(Tag *)tag {
  if (![self hasTag:tag]) {
    ItemTag *newItemTag = (ItemTag *)[ItemTag insertInManagedObjectContext:self.managedObjectContext];
    newItemTag.tag = tag;
    [self addItemTagsObject:newItemTag];
    NSError *error = nil;
    if (![newItemTag.managedObjectContext save:&error]) {
      NSLog(@"Couldn't add ItemTag: %@, %@", error, [error userInfo]);
      abort();
    }
    [[self tags] addObject:tag];
  }
}

- (NSString *) tagDescription {
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
  NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
  NSArray *tagNames = [[NSArray alloc] initWithArray:[self.tags sortedArrayUsingDescriptors:sortDescriptors]];
  [sortDescriptors dealloc];
  [sortDescriptor dealloc];
  NSString *result = [[NSString alloc] initWithString:[tagNames componentsJoinedByString:@", "]];
  [tagNames release];
  return result;
}

- (void) dealloc {
  [tags_ dealloc];
  [super dealloc];
}
   
@end
