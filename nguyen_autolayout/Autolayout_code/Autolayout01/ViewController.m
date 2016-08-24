//
//  ViewController.m
//  Autolayout01
//
//  Created by NguyenMach-MAC on 8/23/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
   
    
    UIView *view1 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
   
    UIView *view2 = [[UIView alloc]init];
    view2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view2];
    
     CGFloat sizeView = (self.view.frame.size.width)/5;
    
     //-------------constraintView1
    NSLayoutConstraint *constraintCenterXV1 = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:0.6 constant:0];
    NSLayoutConstraint *constrainCenterYV1 = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *hightV1 = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:70];
    NSLayoutConstraint *widthV1 = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:sizeView];
  
    [self.view addConstraints:@[constraintCenterXV1,constrainCenterYV1,widthV1,hightV1]];

    view1.autoresizesSubviews = false;
    view1.translatesAutoresizingMaskIntoConstraints = false;
   
    
    //-------------constraintView2
    
    NSLayoutConstraint *constraintCenterXV2 = [NSLayoutConstraint constraintWithItem:view2 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.4 constant:0];
    NSLayoutConstraint *constrainCenterYV2 = [NSLayoutConstraint constraintWithItem:view2 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view1 attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *hightV2 = [NSLayoutConstraint constraintWithItem:view2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:view1 attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    NSLayoutConstraint *widthV2 = [NSLayoutConstraint constraintWithItem:view2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view1 attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    
    [self.view addConstraints:@[constraintCenterXV2,constrainCenterYV2,widthV2,hightV2]];
    
    view2.autoresizesSubviews = false;
    view2.translatesAutoresizingMaskIntoConstraints = false;
  

    
}


-(void)viewWillAppear:(BOOL)animated{

    NSLog(@"heloooo");
}

-(void)viewDidDisappear:(BOOL)animated{

    NSLog(@"aaaaa");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
