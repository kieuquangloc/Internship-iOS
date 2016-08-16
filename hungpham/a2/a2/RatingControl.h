//
//  RatingControl.h
//  FoodTracker
//
//  Created by Hungpv on 8/15/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingControl : UIView

@property (assign) int rating;
@property (assign) int spacing;
@property (assign) int starCount;
@property (strong) NSMutableArray *ratingButtons;

- (void)updateButtonSelectonStates;
- (id)initWithCoder:(NSCoder *)aDecoder;

@end
