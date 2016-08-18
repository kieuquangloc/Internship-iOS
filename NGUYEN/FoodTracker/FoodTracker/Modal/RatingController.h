//
//  RatingController.h
//  FoodTracker
//
//  Created by NguyenMach-MAC on 8/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingController : UIView

@property(nonatomic,assign) NSInteger  rating;
@property(nonatomic,strong) NSMutableArray *ratingbuttons;

@property(nonatomic,assign)NSInteger spasing;
@property(nonatomic,assign)NSInteger starCount;

@end
