#import "_SetList.h"

@class Item;

@interface SetList : _SetList {
  NSArray *sortedItems_;
}

@property (nonatomic, retain) NSArray *sortedItems_;

-(NSInteger)countOf:(Item *)item;
-(NSArray*)sortedItems;
-(void)moveItemFromRow:(NSUInteger)fromRow toRow:(NSUInteger)toRow;
-(void)deleteItemAtIndex:(NSUInteger)index;

@end
