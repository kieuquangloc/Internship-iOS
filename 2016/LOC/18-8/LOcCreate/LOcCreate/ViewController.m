//
//  ViewController.m
//  LOcCreate
//
//  Created by QuangLoc on 8/15/16.
//  Copyright © 2016 QuangLoc. All rights reserved.
//

#import "ViewController.h"
#import "VC2.h"

@interface ViewController () <VC2Delegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBtnShow:(id)sender {
    if (_vDeDanh) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        VC2 *vc = [storyboard instantiateViewControllerWithIdentifier:@"VC2"];
        vc.strTitle = @"VC 2";
        vc.arrData = @[[NSNumber numberWithInteger:1], @2, @3, @4];
        
        vc.delegate = self;
        
        if (vc) {
            [self presentViewController:vc animated:NO completion:nil];
        }
        
    }
}

#pragma mark - VC2 Delegate

- (void)vC2:(VC2 *)vc2 didPressOnViewRate:(UIView *)view withData:(NSArray *)arrData{
    
    NSLog(@"Username:%@ Password: %@", arrData.firstObject, arrData.lastObject);
}

/*
- (void)vC2:(VC2 *)vc2 didLongPressOnViewRate:(UIView *)view{
    NSLog(@"vC2:(VC2 *)vc2 didLongPressOnViewRate");
}

 */



@end
