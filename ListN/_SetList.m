// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SetList.m instead.

#import "_SetList.h"

@implementation SetListID
@end

@implementation _SetList

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SetList" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SetList";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SetList" inManagedObjectContext:moc_];
}

- (SetListID*)objectID {
	return (SetListID*)[super objectID];
}




@dynamic title;






@dynamic date;








@end
