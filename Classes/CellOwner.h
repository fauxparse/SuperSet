//
//  CellOwner.h
//  ListN
//
//  Created by Matt Powell on 18/08/10.
//  Copyright 2010 Matt Powell. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CellOwner : NSObject {
  UITableViewCell *cell;
}

@property (nonatomic, retain) IBOutlet UITableViewCell *cell;

- (BOOL)loadMyNibFile:(NSString *)nibName;

@end
