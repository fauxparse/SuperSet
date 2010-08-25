#import "Item.h"

@implementation Item

@synthesize tags_;

@dynamic firstLetter;

- (NSString *) firstLetter {
  if (firstLetter_ == nil) {
    firstLetter_ = [[NSString alloc] initWithFormat:@"%c", [self.title characterAtIndex:0]];
  }
  return firstLetter_;
}

- (NSMutableSet *) tags {
  if (!tags_) {
    self.tags_ = [[NSMutableSet alloc] initWithCapacity:[self.itemTags count]];
    [self.tags_ autorelease];

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
  [tagValues release];
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
  [result autorelease];
  [tagNames release];
  return result;
}

- (void) destroy {
  [self.managedObjectContext deleteObject:self];
  NSError *error = nil;
  if (![self.managedObjectContext save:&error]) {
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }
}

- (void) dealloc {
  [firstLetter_ dealloc];
  [tags_ dealloc];
  [super dealloc];
}
   
@end
