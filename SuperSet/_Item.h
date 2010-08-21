// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Item.h instead.

#import <CoreData/CoreData.h>


@class SetListItem;
@class ItemTag;




@interface ItemID : NSManagedObjectID {}
@end

@interface _Item : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ItemID*)objectID;



@property (nonatomic, retain) NSString *title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *genre;

//- (BOOL)validateGenre:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* setListItems;
- (NSMutableSet*)setListItemsSet;



@property (nonatomic, retain) NSSet* itemTags;
- (NSMutableSet*)itemTagsSet;



@end

@interface _Item (CoreDataGeneratedAccessors)

- (void)addSetListItems:(NSSet*)value_;
- (void)removeSetListItems:(NSSet*)value_;
- (void)addSetListItemsObject:(SetListItem*)value_;
- (void)removeSetListItemsObject:(SetListItem*)value_;

- (void)addItemTags:(NSSet*)value_;
- (void)removeItemTags:(NSSet*)value_;
- (void)addItemTagsObject:(ItemTag*)value_;
- (void)removeItemTagsObject:(ItemTag*)value_;

@end

@interface _Item (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;


- (NSString*)primitiveGenre;
- (void)setPrimitiveGenre:(NSString*)value;




- (NSMutableSet*)primitiveSetListItems;
- (void)setPrimitiveSetListItems:(NSMutableSet*)value;



- (NSMutableSet*)primitiveItemTags;
- (void)setPrimitiveItemTags:(NSMutableSet*)value;


@end
