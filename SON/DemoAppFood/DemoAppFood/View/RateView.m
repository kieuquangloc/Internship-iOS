//
//  RatingControl.m
//  FoodTracker
//
//  Created by ThanhSon on 8/15/16.
//  Copyright © 2016 ThanhSon. All rights reserved.
//

#import "RateView.h"

@implementation RateView

#pragma mark - InitView

- (void)InitLayout {
    _notSelectedImage = [UIImage imageNamed:@"emptyStar"];;
    _fullSelectedImage = [UIImage imageNamed:@"filledStar"];
    _rating = 0;
    _imageViews = [[NSMutableArray alloc] init];
    _maxRating = 5;
    _delegate = nil;
    
    for(int i = 0; i < _maxRating; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.imageViews addObject:imageView];
        [self addSubview:imageView];
    }
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self InitLayout];
    }
    return self;
}



- (void)layoutSubviews {
    [super layoutSubviews];
    float imageWidthX =0;
    float imageWidth = 40;
    float imageHeight = 40;
    for (int i = 0; i < _maxRating; ++i) {
        UIImageView *imageView = [self.imageViews objectAtIndex:i];
        CGRect imageFrame = CGRectMake(imageWidthX, 0, imageWidth, imageHeight);
        imageWidthX +=45;
        imageView.frame = imageFrame;
    }
}

- (void)setRating:(NSInteger)rating {
    _rating = rating;
    [self refresh];
}

#pragma mark - refresh

- (void)refresh {
    for(int i = 0; i < _maxRating; i++ ) {
        UIImageView *imageView = [self.imageViews objectAtIndex:i];
        if (_rating >= i) {
            imageView.image = self.fullSelectedImage;
        } else {
            imageView.image = self.notSelectedImage;
        }
    }
}

#pragma mark - Action

- (void)handleTouchAtLocation:(CGPoint)touchLocation {
    int newRating = _maxRating-1;
    UIImageView *imageView = [self.imageViews objectAtIndex:newRating];
    while (touchLocation.x < imageView.frame.origin.x) {
        newRating --;
        if (newRating >= 0) {
           imageView = [self.imageViews objectAtIndex:newRating];
        } else {
            break;
        }
    }
    self.rating = newRating;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    [self handleTouchAtLocation:touchLocation];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    [self handleTouchAtLocation:touchLocation];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.delegate rateView:self ratingDidChange:self.rating];
}

@end
