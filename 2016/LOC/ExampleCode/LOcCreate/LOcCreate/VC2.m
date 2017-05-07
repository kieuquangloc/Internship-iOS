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
    lblTitle.text = _strTitle;
    [lblTitle setTextAlignment:(NSTextAlignmentCenter)];
    
    [self.view addSubview:lblTitle];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Action
- (void)onTapGesture:(UITapGestureRecognizer *)tap{
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
