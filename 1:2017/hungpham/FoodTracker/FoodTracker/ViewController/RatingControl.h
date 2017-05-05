//
//  RatingControl.h
//  FoodTracker
//
//  Created by Hungpv on 8/18/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingControl : UIView

@property (assign) NSInteger rating;
@property (assign) NSInteger spacing;
@property (assign) NSInteger starCount;
@property (strong) NSMutableArray *ratingButtons;

- (void)updateButtonSelectonStates;


@end
