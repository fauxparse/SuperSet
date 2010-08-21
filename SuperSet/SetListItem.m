#import "SetListItem.h"

@implementation SetListItem

-(void)updatePosition:(NSUInteger)pos {
  self.position = [NSNumber numberWithInteger:pos];
  NSError *error = nil;
	if (![self.managedObjectContext save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
  }
}

@end
