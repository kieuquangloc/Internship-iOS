//
//  RateView.h
//  FoodTracker
//
//  Created by ThanhSon on 8/15/16.
//  Copyright © 2016 ThanhSon. All rights reserved.
//


#import <UIKit/UIKit.h>

@class RateView;

@protocol RateViewDelegate
- (void)rateView:(RateView *)rateView ratingDidChange:(NSInteger)rating;
@end

@interface RateView : UIView

@property (strong, nonatomic) UIImage *notSelectedImage;
@property (strong, nonatomic) UIImage *fullSelectedImage;

@property (assign, nonatomic) NSInteger rating;
@property (strong) NSMutableArray * imageViews;
@property (assign, nonatomic) int maxRating;

@property (strong) id <RateViewDelegate> delegate;

@end
