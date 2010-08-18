// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SetListItem.h instead.

#import <CoreData/CoreData.h>


@class Item;
@class SetList;




@interface SetListItemID : NSManagedObjectID {}
@end

@interface _SetListItem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SetListItemID*)objectID;



@property (nonatomic, retain) NSString *notes;

//- (BOOL)validateNotes:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *position;

@property short positionValue;
- (short)positionValue;
- (void)setPositionValue:(short)value_;

//- (BOOL)validatePosition:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) Item* item;
//- (BOOL)validateItem:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) SetList* setList;
//- (BOOL)validateSetList:(id*)value_ error:(NSError**)error_;



@end

@interface _SetListItem (CoreDataGeneratedAccessors)

@end

@interface _SetListItem (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveNotes;
- (void)setPrimitiveNotes:(NSString*)value;


- (NSNumber*)primitivePosition;
- (void)setPrimitivePosition:(NSNumber*)value;

- (short)primitivePositionValue;
- (void)setPrimitivePositionValue:(short)value_;




- (Item*)primitiveItem;
- (void)setPrimitiveItem:(Item*)value;



- (SetList*)primitiveSetList;
- (void)setPrimitiveSetList:(SetList*)value;


@end
