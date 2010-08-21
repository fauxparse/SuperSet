// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Item.m instead.

#import "_Item.h"

@implementation ItemID
@end

@implementation _Item

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Item";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Item" inManagedObjectContext:moc_];
}

- (ItemID*)objectID {
	return (ItemID*)[super objectID];
}




@dynamic title;






@dynamic genre;






@dynamic setListItems;

	
- (NSMutableSet*)setListItemsSet {
	[self willAccessValueForKey:@"setListItems"];
	NSMutableSet *result = [self mutableSetValueForKey:@"setListItems"];
	[self didAccessValueForKey:@"setListItems"];
	return result;
}
	

@dynamic itemTags;

	
- (NSMutableSet*)itemTagsSet {
	[self willAccessValueForKey:@"itemTags"];
	NSMutableSet *result = [self mutableSetValueForKey:@"itemTags"];
	[self didAccessValueForKey:@"itemTags"];
	return result;
}
	



@end
