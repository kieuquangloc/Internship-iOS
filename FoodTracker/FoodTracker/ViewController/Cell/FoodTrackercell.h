//
//  FoodTrackercell.h
//  FoodTracker
//
//  Created by NguyenMach-MAC on 8/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "BaseCell.h"
#import "RatingController.h"

@interface FoodTrackercell : BaseCell

@property(nonatomic,weak) IBOutlet UIImageView* imvFood;
@property(nonatomic,weak)IBOutlet UILabel * lblName;
@property(nonatomic,strong) RatingController *ratingController;

@end
