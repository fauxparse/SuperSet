//
//  RedButtonCell.m
//  SuperSet
//
//  Created by Matt Powell on 22/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RedButtonCell.h"

@implementation RedButtonCell

@synthesize button;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
    // Initialization code
  }
  return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  // Configure the view for the selected state
}


- (void)dealloc {
  [button release];
  [super dealloc];
}


@end
