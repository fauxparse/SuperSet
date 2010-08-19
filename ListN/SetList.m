#import "SetList.h"
#import "SetListItem.h"

@implementation SetList

- (NSInteger) countOf:(Item *)item {
  NSInteger c = 0;
  for (SetListItem *sli in self.setListItems) {
    if ([[sli item] objectID] == [item objectID]) {
      c++;
    }
  }
  return c;
}

//- (void)addSetListItemsObject:(SetListItem*)value_ {
//  value_.position = [NSNumber numberWithInteger:[recipe.ingredients count]];
//  [super addSetListItemsObject:value_];
//}

@end
