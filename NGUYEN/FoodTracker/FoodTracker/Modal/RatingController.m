//
//  RatingController.m
//  FoodTracker
//
//  Created by NguyenMach-MAC on 8/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "RatingController.h"


@implementation RatingController


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    _rating = 0;
    _spasing = 5;
    _starCount = 5;
    _ratingbuttons = [[NSMutableArray alloc]init];
    
    if (self) {
        
        UIImage * imgEmptyStar = [UIImage imageNamed:@"emptyStar"];
        UIImage *imgFilledStar = [UIImage imageNamed:@"filledStar"];
        
        for (int i = 0; i<5; i++) {
            
            UIButton *button = [[UIButton alloc]init];
            button.frame = CGRectMake(0, 0, 44, 44);
            
            [button setImage:imgEmptyStar forState: UIControlStateNormal];
            [button setImage:imgFilledStar forState: UIControlStateHighlighted | UIControlStateSelected ];
            [button setImage:imgFilledStar forState:UIControlStateSelected];
            
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

  //  printf("ban dang chon");
    
    _rating = (NSInteger)([_ratingbuttons indexOfObject:button] + 1);
    
   // NSLog(@"%d",[_ratingbuttons indexOfObject:button]);
    
    [self updateButtonSeclectStatus];
    
    
}

-(void)updateButtonSeclectStatus{

    for (NSInteger index = 0;index < _starCount; index++) {
        
          UIButton *btnStar = _ratingbuttons[index];
            
            btnStar.selected = index < (NSInteger)_rating;
      
    }
}

@end
