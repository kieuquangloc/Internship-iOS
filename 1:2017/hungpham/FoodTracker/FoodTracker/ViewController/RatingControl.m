//
//  RatingControl.m
//  FoodTracker
//
//  Created by Hungpv on 8/18/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "RatingControl.h"

@implementation RatingControl

- (void)awakeFromNib{
    [super awakeFromNib];
    _spacing = 5;
    _starCount = 5;
    
    UIImage *emptyStarImage = [UIImage imageNamed:@"emptyStar"];
    UIImage *filledStarImage = [UIImage imageNamed:@"filledStar"];
    
    if (self) {
        _ratingButtons = [[NSMutableArray alloc]init];
        
        for (int i = 0; i < _starCount; i++) {
            
            UIButton *button = [[UIButton alloc]init];
            
            [button setImage:emptyStarImage forState:UIControlStateNormal];
            [button setImage:filledStarImage forState:UIControlStateSelected];
            [button setImage:filledStarImage forState:UIControlStateSelected | UIControlStateHighlighted];
            
            button.showsTouchWhenHighlighted = YES;
            
            [button setAdjustsImageWhenDisabled:false];
            [button addTarget:self action:@selector(ratingButtonTapped:) forControlEvents:UIControlEventTouchDown];
            
            [_ratingButtons addObject:button];
        }
        
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    int buttonSize = self.frame.size.height;
    CGRect buttonFrame = CGRectMake(0, 0, 44, 44);
    
    for (int i = 0; i < [_ratingButtons count]; i++) {
        CGFloat width = i * (buttonSize + _spacing);
        buttonFrame.origin.x = width;
        UIButton *btn = [_ratingButtons objectAtIndex:i];
        btn.frame = buttonFrame;
        [self addSubview:btn];
    }
    
    [self updateButtonSelectonStates];
}

- (CGSize)intrinsicContentSize {
    int buttonSize = self.frame.size.height;
    CGFloat with = (buttonSize * _starCount) + (_spacing * (_starCount - 1));
    CGSize size = CGSizeMake(with, buttonSize);
    
    return size;
}


#pragma mark - Action.

- (void)ratingButtonTapped:(UIButton *)btn {
    _rating = (int)([_ratingButtons indexOfObject:btn] + 1);
    [self updateButtonSelectonStates];
}

- (void)updateButtonSelectonStates {
    for (int i = 0; i < [_ratingButtons count]; i++) {
        UIButton *btn = [_ratingButtons objectAtIndex:i];
        btn.selected = i < _rating;
    }
}


@end
