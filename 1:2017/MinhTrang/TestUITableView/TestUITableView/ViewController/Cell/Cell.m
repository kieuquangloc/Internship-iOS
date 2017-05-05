//
//  Cell.m
//  TestUITableView
//
//  Created by Miracle on 1/18/17.
//  Copyright © 2017 Miracle. All rights reserved.
//

#import "Cell.h"

@interface Cell () <UITextFieldDelegate>

@end

@implementation Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _tfContent.delegate = self;
    _tfKey1.delegate = self;
    _tfKey2.delegate = self;
    _tfKey3.delegate = self;
    _tfKey4.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (_delegate && [_delegate respondsToSelector:@selector(cell:didChangeString:inTextfield:)]) {
        
        [_delegate cell:self didChangeString:str inTextfield:textField];
        
    }else{
        NSLog(@"Please set delegate for this Cell");
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (_delegate && [_delegate respondsToSelector:@selector(cell:didBeginEditting:)]) {
        [_delegate cell:self didBeginEditting:textField];
    }else{
        NSLog(@"Please set delegate for this Cell");
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (_delegate && [_delegate respondsToSelector:@selector(cell:didEndEditting:)]) {
        [_delegate cell:self didEndEditting:textField];
    }else{
        NSLog(@"Please set delegate for this Cell");
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (_delegate && [_delegate respondsToSelector:@selector(cell:didPressReturn:)]) {
        [_delegate cell:self didPressReturn:textField];
    }else{
        NSLog(@"Please set delegate for this Cell");
    }
    
    return YES;
}


@end
