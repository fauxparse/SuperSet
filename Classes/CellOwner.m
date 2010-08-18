//
//  CellOwner.m
//  ListN
//
//  Created by Matt Powell on 18/08/10.
//  Copyright 2010 Matt Powell. All rights reserved.
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
