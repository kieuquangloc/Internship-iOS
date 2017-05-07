//
//  Cell.h
//  FoodTracker
//
//  Created by Hungpv on 8/18/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingControl.h"

@interface Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ivMealPoto;

@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (weak, nonatomic) IBOutlet RatingControl *viRating;

@end
