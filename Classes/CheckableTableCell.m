//
//  CheckableTableCell.m
//  SuperSet
//
//  Created by Matt Powell on 19/08/10.
//  Copyright 2010 Matt Powell. All rights reserved.
//

#import "CheckableTableCell.h"


@implementation CheckableTableCell

@synthesize checked_, titleLabel, descriptionLabel, countLabel, checkedImage;

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

- (BOOL)checked {
  return self.checked_;
}

- (void)setChecked:(BOOL)checkedState {
  self.checked_ = checkedState;
  self.checkedImage.image = [UIImage imageNamed:(self.checked ? @"checked.png" : @"unchecked.png")];
}

- (void)dealloc {
  [titleLabel release];
  [descriptionLabel release];
  [countLabel release];
  [super dealloc];
}

@end
