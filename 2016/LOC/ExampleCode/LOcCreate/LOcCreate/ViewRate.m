//
//  ViewRate.m
//  LOcCreate
//
//  Created by Kai Hackintosh on 8/18/16.
//  Copyright © 2016 QuangLoc. All rights reserved.
//

#import "ViewRate.h"

@implementation ViewRate{
    NSMutableArray *_arrButton;
}


- (void)awakeFromNib{
    if (!_arrButton) {
        _arrButton = [NSMutableArray array];
        
        
        for (int i = 0; i < 3; i++) {
            CGRect frame = CGRectMake(i*40, 0, 30, 30);
            UIButton *btn = [[UIButton alloc]initWithFrame:frame];
            [btn setBackgroundColor:[UIColor blueColor]];
            [btn addTarget:self action:@selector(onBtnStar) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
        }
    }
    
}
         - (void)onBtnStar{
             NSLog(@"pressed !!");
         }
@end
