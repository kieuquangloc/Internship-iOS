//
//  AddViewController.m
//  MenuFood
//
//  Created by Quyen Dang on 8/14/16.
//  Copyright © 2016 AnhSinGum. All rights reserved.
//

#import "AddViewController.h"
#import "Food.h"
#import "DataManager.h"
@interface AddViewController() <UITextFieldDelegate>
@end
@implementation AddViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.rateLabel.text = [NSString stringWithFormat:@"%f", self.rateStepper.value];
    self.nameLabel.delegate = self;
    self.imageLabel.delegate = self;
    
    
}

#pragma make TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.nameLabel) {
        [self.nameLabel resignFirstResponder];
    }
    
    if (textField == self.imageLabel) {
        [self.imageLabel resignFirstResponder];
    }
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}


#pragma mark App Avent

- (IBAction)onRateValuChange:(id)sender {
    self.rateLabel.text = [NSString stringWithFormat:@"%f", self.rateStepper.value];
}
- (IBAction)onAddClick:(id)sender {
    
    if (self.nameLabel.text.length > 0 && self.imageLabel.text.length > 0) {
        Food *item = [[Food alloc] init];
        item.name = self.nameLabel.text;
        item.image = self.imageLabel.text;
        item.rate = (NSInteger)self.rateStepper.value;
        [[DataManager shareIntance].foodList addObject:item];
        [[DataManager shareIntance] saveBack];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else{
        self.nameLabel.backgroundColor = [UIColor redColor];
        self.imageLabel.backgroundColor = [UIColor redColor];
    }
}
@end
