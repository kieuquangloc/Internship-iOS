//
//  ItemCell.h
//  FoodTracker
//
//  Created by HHumorous on 9/21/17.
//  Copyright © 2017 HHumorous. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingStarControl.h"

@interface ItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView1;
@property (weak, nonatomic) IBOutlet UILabel *mealName;
@property (weak, nonatomic) IBOutlet RatingStarControl *ratingStar;
@end
