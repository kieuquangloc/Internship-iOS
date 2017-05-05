//
//  ViewController.m
//  Autolayout-bycode
//
//  Created by Hungpv on 8/24/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view1 = [[UIView alloc]init];
    UIView *view2 = [[UIView alloc]init];

    view1.backgroundColor = [UIColor greenColor];
    view2.backgroundColor = [UIColor yellowColor];
    
    view1.autoresizingMask = NO;
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    
    view2.autoresizingMask = NO;
    view2.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    
    // set Height
    NSLayoutConstraint *v1Height = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.2 constant:0];
    
    // view1 center Y
    NSLayoutConstraint *v1centerY = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    
    // view2 center Y
    NSLayoutConstraint *v2centerY = [NSLayoutConstraint constraintWithItem:view2 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    //
    // view1 trailing with superview
    NSLayoutConstraint *v1leading = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:80];
    
    // view1 leading with view2
    NSLayoutConstraint *v1leadingv2 = [NSLayoutConstraint constraintWithItem:view2 attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view1 attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:80];
    
    // view2 leading with superview
    NSLayoutConstraint *v2trailing = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:80];
    
    
    // view1 equalwidth with view2
    NSLayoutConstraint *equalWidth = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    
    // view1 equalheight with view2
    NSLayoutConstraint *equalHeight = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    
    
    [self.view addConstraint:v1Height];
    [self.view addConstraint:v1centerY];
    [self.view addConstraint:v2centerY];
    [self.view addConstraint:v1leading];
    [self.view addConstraint:v1leadingv2];
    [self.view addConstraint:v2trailing];
    [self.view addConstraint:equalHeight];
    [self.view addConstraint:equalWidth];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
