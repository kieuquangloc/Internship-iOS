//
//  ViewRate.m
//  LOcCreate
//
//  Created by QuangLoc on 8/18/16.
//  Copyright © 2016 QuangLoc. All rights reserved.
//

#import "ViewRate.h"

@implementation ViewRate{
    NSMutableArray *_arrBtn;
}

- (void)awakeFromNib{
    if (!_arrBtn) {
        _arrBtn = [NSMutableArray array];
        
        NSLog(@"self: %@",self);
        
        CGRect bound = self.bounds;
        CGRect frame = self.frame;
        CGFloat w = bound.size.width;
        CGFloat numberBtn = 10;
        CGFloat wBtn = w/(numberBtn*2 - 1);
        
        CGFloat h = bound.size.height;
        
        
        
        NSLog(@"bound: %@ frame: %@", NSStringFromCGRect(bound), NSStringFromCGRect(frame));
        
        
        
        for (NSInteger i = 0; i<numberBtn; i++) {
            CGRect frame = CGRectMake(i*wBtn*2, wBtn*i*2, wBtn, wBtn);
            UIButton *btn = [[UIButton alloc] initWithFrame:frame];
            [btn setBackgroundColor:[UIColor grayColor]];
            
            [btn addTarget:self action:@selector(onBtnStar) forControlEvents:(UIControlEventTouchUpInside)];
            
            [self addSubview:btn];
        }
    }
}

- (void)onBtnStar{
    NSLog(@"pressed!!");
}

@end
