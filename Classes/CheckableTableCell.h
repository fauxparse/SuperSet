//
//  CheckableTableCell.h
//  ListN
//
//  Created by Matt Powell on 19/08/10.
//  Copyright 2010 Matt Powell. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CheckableTableCell : UITableViewCell {
  BOOL checked_;
  IBOutlet UILabel *titleLabel;
  IBOutlet UILabel *descriptionLabel;
  IBOutlet UILabel *countLabel;
  IBOutlet UIImageView *checkedImage;
}

@property (nonatomic, assign) BOOL checked_;
@property (nonatomic, assign) BOOL checked;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, retain) IBOutlet UILabel *countLabel;
@property (nonatomic, retain) IBOutlet UIImageView *checkedImage;

@end
