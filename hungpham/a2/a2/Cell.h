//
//  Cell.h
//  a2
//
//  Created by Hungpv on 8/16/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingControl.h"
@class Cell;
@protocol CellDelegate <NSObject>


- (void)CellDelegate:(Cell *)cell withActionBtn:(UIButton *)btn;
@optional



@required

@end
@interface Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ivPhoto;
@property (weak, nonatomic) IBOutlet UILabel *lblMealname;
@property (weak, nonatomic) IBOutlet RatingControl *viRatinh;

//Delegate.

@property (weak, nonatomic) id<CellDelegate>delegate;

@end
