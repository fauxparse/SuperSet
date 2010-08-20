#import "Tag.h"

@implementation Tag

- (NSString *)description {
  return [self tag];
}

- (NSComparisonResult)compare:(Tag *)aTag {
  return [self.tag caseInsensitiveCompare:[aTag tag]];
}

@end
