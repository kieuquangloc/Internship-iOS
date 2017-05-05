//
//  VC2.m
//  LOcCreate
//
//  Created by QuangLoc on 8/18/16.
//  Copyright © 2016 QuangLoc. All rights reserved.
//

#import "VC2.h"

@interface VC2 ()

@end

@implementation VC2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGesture:)];
    [self.view addGestureRecognizer:tap];
    
    
    CGRect frame = CGRectMake(0, 0, 200, 50);
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:frame];
    lblTitle.center = self.view.center;
    
    NSString *strTemp = [NSString stringWithFormat:@"%@ + %ld", _strTitle, [_arrData[0] integerValue]];
    lblTitle.text = strTemp;
    [lblTitle setTextAlignment:(NSTextAlignmentCenter)];
    
    
    [self.view addSubview:lblTitle];
    
    
    //ViewRate
    UITapGestureRecognizer *tapViewRate = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapViewRate:)];
    [_vRate addGestureRecognizer:tapViewRate];
    
    UILongPressGestureRecognizer *longTapViewRate = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongTapViewRate:)];
    [_vRate addGestureRecognizer:longTapViewRate];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Action
- (void)onTapGesture:(UITapGestureRecognizer *)tap{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)onTapViewRate:(UITapGestureRecognizer *)tap{
    NSLog(@"onTapViewRate");
    
    NSArray *arrData = @[@"UserName", @"Password"];
    
    if (_delegate && [_delegate respondsToSelector:@selector(vC2:didPressOnViewRate:withData:)]) {
        [_delegate vC2:self didPressOnViewRate:_vRate withData:arrData];
    }else{
        NSLog(@"Delegate = nil, please set delegate!!!!!");
    }
}

- (void)onLongTapViewRate:(UILongPressGestureRecognizer *)tap{
    NSLog(@"onLongTapViewRate");
}


@end
