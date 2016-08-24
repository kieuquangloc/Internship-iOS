//
//  ViewController.m
//  DemoAutoLayout
//
//  Created by Hackintosh-DatSinGum on 8/23/16.
//  Copyright © 2016 AnhSinGum. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btRed = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [btRed setTranslatesAutoresizingMaskIntoConstraints:NO];
    UIButton *btBlue = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [btBlue setTranslatesAutoresizingMaskIntoConstraints:NO];
//    NSInteger a = self.view.center.x;
//    NSInteger b = self.view.center.y;
   // btRed.frame = CGRectMake(nil, nil, 100, 100);
    [self.view addSubview:btRed];
    btRed.backgroundColor = [UIColor redColor];
    btBlue.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btBlue];
    
    NSLayoutConstraint *contrains = [NSLayoutConstraint constraintWithItem:btRed
                                                        attribute:NSLayoutAttributeCenterY relatedBy: NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    
    [self.view addConstraint:contrains];
    
    
    contrains = [NSLayoutConstraint constraintWithItem:btBlue
                                    attribute:NSLayoutAttributeCenterY
                                    relatedBy: NSLayoutRelationEqual toItem:self.view
                                    attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    
    [self.view addConstraint:contrains];
    
//    contrains = [NSLayoutConstraint constraintWithItem:btRed
//                                             attribute:NSLayoutAttributeWidth
//                                             relatedBy: NSLayoutRelationEqual toItem:self.view
//                                             attribute:NSLayoutAttributeWidth multiplier:0.2 constant:0];
//    [self.view addConstraint:contrains];
    
//    contrains = [NSLayoutConstraint constraintWithItem:btRed
//                                             attribute:NSLayoutAttributeHeight
//                                             relatedBy: NSLayoutRelationEqual toItem:self.view
//                                             attribute:NSLayoutAttributeHeight multiplier:0.3 constant:0];
//     [self.view addConstraint:contrains];
    NSInteger V = self.view.frame.size.width;
    NSInteger a = btRed.frame.size.width;
    contrains = [NSLayoutConstraint constraintWithItem:btRed
                                             attribute:NSLayoutAttributeLeading
                                             relatedBy: NSLayoutRelationEqual toItem:self.view
                                             attribute:NSLayoutAttributeLeading multiplier:1.0 constant:(V - 2*a)/3];
    [self.view addConstraint:contrains];
    
    contrains = [NSLayoutConstraint constraintWithItem:btBlue
                                             attribute:NSLayoutAttributeLeading
                                             relatedBy: NSLayoutRelationEqual toItem:btRed
                                             attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:(V - 2*a)/3];
    [self.view addConstraint:contrains];
    
    contrains = [NSLayoutConstraint constraintWithItem:btBlue
                                             attribute:NSLayoutAttributeTrailing
                                             relatedBy: NSLayoutRelationEqual toItem:self.view
                                             attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-(V - 2*a)/3];
    [self.view addConstraint:contrains];

    contrains = [NSLayoutConstraint constraintWithItem:btBlue
                                             attribute:NSLayoutAttributeWidth
                                             relatedBy: NSLayoutRelationEqual toItem:btRed
                                             attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    [self.view addConstraint:contrains];
    
    contrains = [NSLayoutConstraint constraintWithItem:btBlue
                                             attribute:NSLayoutAttributeHeight
                                             relatedBy: NSLayoutRelationEqual toItem:btRed
                                             attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    [self.view addConstraint:contrains];
    
    


    
    
    //[]

    //btBlue.backgroundColor = [UIColor blueColor];
    
    //VIEW.NSLayoutConstraint;
    
    
//    [self.view addSubview:blueView];
//    //UIView *fview = self.view;
//    //NSInteger *a = [[self.view.frame.size.;height ] ];
//    CGFloat a = 80;
//   // redView.frame  = CGRectMake(self.view.center.x - a/2, self.view.center.y - a/2 , a, a);
//    blueView.frame = CGRectMake(self.view.center.x + a/2, self.view.center.y - a/2, a, a);
//    redView.backgroundColor  = [UIColor redColor];
//    blueView.backgroundColor = [UIColor blueColor];
//   
//    //redView.leadingAnchor = blueView.trailingAnchor+ 50;
//    redView.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    NSLayoutConstraint(item: redView, attribute: , relatedBy: .Equal, toItem: view, attribute: .LeadingMargin, multiplier: 1.0, constant: 0.0).active = true
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
