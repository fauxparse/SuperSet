//
//  CellOwner.m
//  SuperSet
//
//  By HenrikB
//  http://humblecoder.blogspot.com/2009/05/iphone-tutorial-creating-table-cells-in.html
//

#import "CellOwner.h"

@implementation CellOwner

@synthesize cell;

- (BOOL)loadMyNibFile:(NSString *)nibName {
  // The myNib file must be in the bundle that defines self's class.
  if ([[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] == nil) {
    NSLog(@"Warning! Could not load %@ file.\n", nibName);
    return NO;
  }
  return YES;
}

@end
