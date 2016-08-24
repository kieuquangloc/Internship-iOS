//
//  ContrainByCodeVC.m
//  autolayout2Button
//
//  Created by Kai Hackintosh on 8/23/16.
//  Copyright © 2016 Kai Hackintosh. All rights reserved.
//

#import "ContrainByCodeVC.h"

@interface ContrainByCodeVC ()

@end

@implementation ContrainByCodeVC

- (void)viewDidLoad{
    [super viewDidLoad];
    UIButton *btn1 = [[UIButton alloc]init];
    btn1.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn1];
    
    
    CGFloat w = (self.view.frame.size.width)/5;
    
    btn1.autoresizesSubviews = NO;
    btn1.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    NSLayoutConstraint *constraintX1 = [NSLayoutConstraint
                                       constraintWithItem:btn1
                                       attribute:NSLayoutAttributeCenterX
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:self.view
                                       attribute:NSLayoutAttributeCenterX
                                       multiplier:1
                                       constant:w];
    
    NSLayoutConstraint *constraintY1 = [NSLayoutConstraint
                                       constraintWithItem:btn1
                                       attribute:NSLayoutAttributeCenterY
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:self.view
                                       attribute:NSLayoutAttributeCenterY
                                       multiplier:1
                                       constant:0];
    
    NSLayoutConstraint *constraintW1 = [NSLayoutConstraint
                                       constraintWithItem:btn1
                                       attribute:NSLayoutAttributeWidth
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:self.view
                                       attribute:NSLayoutAttributeWidth
                                       multiplier:0.2
                                       constant:0];
    
    
    NSLayoutConstraint *constraintH1 = [NSLayoutConstraint
                                       constraintWithItem:btn1
                                       attribute:NSLayoutAttributeHeight
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:self.view
                                       attribute:NSLayoutAttributeHeight
                                       multiplier:0.2
                                       constant:0];
    
    [self.view addConstraint:constraintX1];
    [self.view addConstraint:constraintY1];
    [self.view addConstraint:constraintW1];
    [self.view addConstraint:constraintH1];
    
    
    
    UIButton *btn2 = [[UIButton alloc]init];
    btn2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:btn2];
    btn2.autoresizesSubviews = NO;
    btn2.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraintX2 = [NSLayoutConstraint
                                        constraintWithItem:btn2
                                        attribute:NSLayoutAttributeCenterX
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:btn1
                                        attribute:NSLayoutAttributeCenterX
                                        multiplier:1
                                        constant:-(w*2)];
    
    NSLayoutConstraint *constraintY2 = [NSLayoutConstraint
                                        constraintWithItem:btn2
                                        attribute:NSLayoutAttributeCenterY
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.view
                                        attribute:NSLayoutAttributeCenterY
                                        multiplier:1
                                        constant:0];
    
    NSLayoutConstraint *constraintW2 = [NSLayoutConstraint
                                        constraintWithItem:btn2
                                        attribute:NSLayoutAttributeWidth
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:btn1
                                        attribute:NSLayoutAttributeWidth
                                        multiplier:1
                                        constant:0];
    
    
    NSLayoutConstraint *constraintH2 = [NSLayoutConstraint
                                        constraintWithItem:btn2
                                        attribute:NSLayoutAttributeHeight
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:btn1
                                        attribute:NSLayoutAttributeHeight
                                        multiplier:1
                                        constant:0];
    
    [self.view addConstraint:constraintX2];
    [self.view addConstraint:constraintY2];
    [self.view addConstraint:constraintW2];
    [self.view addConstraint:constraintH2];
    
    
}
    @end
