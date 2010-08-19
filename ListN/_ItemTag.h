// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ItemTag.h instead.

#import <CoreData/CoreData.h>


@class Tag;
@class Item;


@interface ItemTagID : NSManagedObjectID {}
@end

@interface _ItemTag : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ItemTagID*)objectID;




@property (nonatomic, retain) Tag* tag;
//- (BOOL)validateTag:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) Item* item;
//- (BOOL)validateItem:(id*)value_ error:(NSError**)error_;



@end

@interface _ItemTag (CoreDataGeneratedAccessors)

@end

@interface _ItemTag (CoreDataGeneratedPrimitiveAccessors)



- (Tag*)primitiveTag;
- (void)setPrimitiveTag:(Tag*)value;



- (Item*)primitiveItem;
- (void)setPrimitiveItem:(Item*)value;


@end
