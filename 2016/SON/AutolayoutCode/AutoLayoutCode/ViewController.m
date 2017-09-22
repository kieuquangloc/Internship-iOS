//
//  ViewController.m
//  AutoLayoutCode
//
//  Created by ThanhSon on 8/24/16.
//  Copyright © 2016 ThanhSon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self creatView];
    [self autolayoutView];
}

- (void)creatView {
    _vRed = [[UIView alloc]init];
    [_vRed setBackgroundColor:[UIColor redColor]];
    _vBlue = [[UIView alloc]init];
    [_vBlue setBackgroundColor:[UIColor blueColor]];
    
    [self.view addSubview:_vRed];
    [self.view addSubview:_vBlue];
}

- (void)autolayoutView {
    
    NSLayoutConstraint * centerXBlue = [NSLayoutConstraint constraintWithItem:_vBlue
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:0.5
                                                                    constant:0];
    NSLayoutConstraint * centerYBlue = [NSLayoutConstraint constraintWithItem:_vBlue
                                                                    attribute:NSLayoutAttributeCenterY
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.view
                                                                    attribute:NSLayoutAttributeCenterY
                                                                   multiplier:1
                                                                     constant:0];
    NSLayoutConstraint * equalWidthView = [NSLayoutConstraint constraintWithItem:_vBlue
                                                                    attribute:NSLayoutAttributeWidth
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:_vRed
                                                                    attribute:NSLayoutAttributeWidth
                                                                   multiplier:1
                                                                     constant:0];
    NSLayoutConstraint * equalHeightView = [NSLayoutConstraint constraintWithItem:_vBlue
                                                                    attribute:NSLayoutAttributeHeight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:_vRed
                                                                    attribute:NSLayoutAttributeHeight
                                            ß:                          multiplier:1
                                                                     constant:0];
    NSLayoutConstraint * widthView = [NSLayoutConstraint constraintWithItem:_vBlue
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeWidth
                                                                       multiplier:0.25f
                                                                         constant:0];
    NSLayoutConstraint * heightView = [NSLayoutConstraint constraintWithItem:_vBlue
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeHeight
                                                                       multiplier:0.25f
                                                                         constant:0];
    _vRed.autoresizingMask = false;
    _vRed.translatesAutoresizingMaskIntoConstraints = false;


    [self.view addConstraints:@[centerXBlue,centerYBlue,equalWidthView,equalHeightView,widthView,heightView]];
    
    NSLayoutConstraint * centerXRed = [NSLayoutConstraint constraintWithItem:_vRed
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1.5
                                                                    constant:0];
    NSLayoutConstraint * centerYRed = [NSLayoutConstraint constraintWithItem:_vRed
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1
                                                                    constant:0];
    _vBlue.autoresizingMask = false;
    _vBlue.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addConstraints:@[centerXRed,centerYRed]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
