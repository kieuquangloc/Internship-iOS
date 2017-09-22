//
//  RatingStarControl.h
//  FoodTracker
//
//  Created by HHumorous on 9/20/17.
//  Copyright © 2017 HHumorous. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingStarControl : UIView

@property(nonatomic,assign) NSInteger  rating;
@property(nonatomic,strong) NSMutableArray *ratingbuttons;

@property(nonatomic,assign)NSInteger spasing;
@property(nonatomic,assign)NSInteger starCount;


@end

