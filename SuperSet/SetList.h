#import "_SetList.h"

@class Item;

@interface SetList : _SetList {
  NSMutableArray *sortedItems_;
}

@property (nonatomic, retain) NSMutableArray *sortedItems_;

-(NSInteger)countOf:(Item *)item;
-(NSMutableArray*)sortedItems;
-(void)reload;
-(void)moveItemFromRow:(NSUInteger)fromRow toRow:(NSUInteger)toRow;
-(void)deleteItemAtIndex:(NSUInteger)index;
-(void)addSetListItem:(SetListItem *)item;

@end
