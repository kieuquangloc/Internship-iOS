//
//  RatingStarControl.m
//  FoodTracker
//
//  Created by HHumorous on 9/20/17.
//  Copyright © 2017 HHumorous. All rights reserved.
//

#import "RatingStarControl.h"


@implementation RatingStarControl


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    _rating = 0;
    _spasing = 5;
    _starCount = 5;
    _ratingbuttons = [[NSMutableArray alloc]init];
    
    if (self) {
        
        UIImage * imgEmptyStar = [UIImage imageNamed:@"Star"];
        UIImage *imgFilledStar = [UIImage imageNamed:@"FilledStar"];
        UIImage *highlightStar = [UIImage imageNamed:@"highlightStar"];
        
        for (int i = 0; i<5; i++) {
            
            UIButton *button = [[UIButton alloc]init];
            button.frame = CGRectMake(0, 0, 44, 44);
            
            [button setImage:imgEmptyStar forState: UIControlStateNormal];
            [button setImage:imgFilledStar forState:UIControlStateSelected];
            [button setImage:highlightStar forState:UIControlStateHighlighted];
            [button setImage:highlightStar forState: UIControlStateHighlighted | UIControlStateSelected];
            
            button.adjustsImageWhenHighlighted =  false;
            
            //even click button
            [button addTarget:self action: @selector(ratingButtonTapper:) forControlEvents:   UIControlEventTouchUpInside];
            
            [_ratingbuttons addObject:button];
            
            [self addSubview:button];
        }
    }
    return self;
}

-(void)layoutSubviews{
    
    CGRect buttonFrame = CGRectMake(0, 0, 44, 44);
    
    for (int i = 0; i<_starCount; i++) {
        
        buttonFrame.origin.x = (CGFloat)i*( 44  + (NSInteger)_spasing);
        
        UIButton *btnStart = [_ratingbuttons objectAtIndex:i];
        
        btnStart.frame = buttonFrame;
    }
    
    [self updateButtonSeclectStatus];
    
}

//  size for UIview(need cutom)
-(CGSize)intrinsicContentSize{
    
    return CGSizeMake(240, 44);
}

#pragma mark - ButtonAction

-(void)ratingButtonTapper:(UIButton*)button{
    
    _rating = (NSInteger)([_ratingbuttons indexOfObject:button] + 1);
    
    [self updateButtonSeclectStatus];
}

-(void)updateButtonSeclectStatus{
    
    for (NSInteger index = 0;index < _starCount; index++) {
        
        UIButton *btnStar = _ratingbuttons[index];
        
        btnStar.selected = index < (NSInteger)_rating;
        
    }
}

@end
