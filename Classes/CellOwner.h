//
//  CellOwner.h
//  SuperSet
//
//  By HenrikB
//  http://humblecoder.blogspot.com/2009/05/iphone-tutorial-creating-table-cells-in.html
//

#import <Foundation/Foundation.h>


@interface CellOwner : NSObject {
  UITableViewCell *cell;
}

@property (nonatomic, retain) IBOutlet UITableViewCell *cell;

- (BOOL)loadMyNibFile:(NSString *)nibName;

@end
