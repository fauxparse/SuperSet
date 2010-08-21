// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Tag.h instead.

#import <CoreData/CoreData.h>


@class ItemTag;



@interface TagID : NSManagedObjectID {}
@end

@interface _Tag : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TagID*)objectID;



@property (nonatomic, retain) NSString *tag;

//- (BOOL)validateTag:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* itemTags;
- (NSMutableSet*)itemTagsSet;



@end

@interface _Tag (CoreDataGeneratedAccessors)

- (void)addItemTags:(NSSet*)value_;
- (void)removeItemTags:(NSSet*)value_;
- (void)addItemTagsObject:(ItemTag*)value_;
- (void)removeItemTagsObject:(ItemTag*)value_;

@end

@interface _Tag (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveTag;
- (void)setPrimitiveTag:(NSString*)value;




- (NSMutableSet*)primitiveItemTags;
- (void)setPrimitiveItemTags:(NSMutableSet*)value;


@end
