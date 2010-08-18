// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SetListItem.m instead.

#import "_SetListItem.h"

@implementation SetListItemID
@end

@implementation _SetListItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SetListItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SetListItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SetListItem" inManagedObjectContext:moc_];
}

- (SetListItemID*)objectID {
	return (SetListItemID*)[super objectID];
}




@dynamic notes;






@dynamic position;



- (short)positionValue {
	NSNumber *result = [self position];
	return [result shortValue];
}

- (void)setPositionValue:(short)value_ {
	[self setPosition:[NSNumber numberWithShort:value_]];
}

- (short)primitivePositionValue {
	NSNumber *result = [self primitivePosition];
	return [result shortValue];
}

- (void)setPrimitivePositionValue:(short)value_ {
	[self setPrimitivePosition:[NSNumber numberWithShort:value_]];
}





@dynamic item;

	

@dynamic setList;

	



@end
