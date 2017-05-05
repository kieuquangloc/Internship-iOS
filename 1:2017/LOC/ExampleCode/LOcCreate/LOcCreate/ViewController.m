//
//  ViewController.m
//  LOcCreate
//
//  Created by QuangLoc on 8/15/16.
//  Copyright © 2016 QuangLoc. All rights reserved.
//

#import "ViewController.h"
#import "VC2.h"

@interface ViewController ()

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
        
        if (vc) {
            [self presentViewController:vc animated:NO completion:nil];
        }
        
    }
}

@end
