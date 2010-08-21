//
//  EditableTableCell.h
//  SuperSet
//
//  Created by Matt Powell on 18/08/10.
//  Copyright 2010 Matt Powell. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EditableTableCell : UITableViewCell {
  IBOutlet UITextField *textField;
}

@property (nonatomic, retain) IBOutlet UITextField *textField;

@end
