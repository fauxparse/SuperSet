// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ItemTag.m instead.

#import "_ItemTag.h"

@implementation ItemTagID
@end

@implementation _ItemTag

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ItemTag" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ItemTag";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ItemTag" inManagedObjectContext:moc_];
}

- (ItemTagID*)objectID {
	return (ItemTagID*)[super objectID];
}




@dynamic tag;

	

@dynamic item;

	



@end
