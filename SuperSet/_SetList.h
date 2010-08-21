// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SetList.h instead.

#import <CoreData/CoreData.h>


@class SetListItem;




@interface SetListID : NSManagedObjectID {}
@end

@interface _SetList : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SetListID*)objectID;



@property (nonatomic, retain) NSString *title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *date;

//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* setListItems;
- (NSMutableSet*)setListItemsSet;



@end

@interface _SetList (CoreDataGeneratedAccessors)

- (void)addSetListItems:(NSSet*)value_;
- (void)removeSetListItems:(NSSet*)value_;
- (void)addSetListItemsObject:(SetListItem*)value_;
- (void)removeSetListItemsObject:(SetListItem*)value_;

@end

@interface _SetList (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;


- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;




- (NSMutableSet*)primitiveSetListItems;
- (void)setPrimitiveSetListItems:(NSMutableSet*)value;


@end
