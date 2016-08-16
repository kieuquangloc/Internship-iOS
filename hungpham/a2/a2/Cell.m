//
//  Cell.m
//  a2
//
//  Created by Hungpv on 8/16/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "Cell.h"

@implementation Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)btnAction:(UIButton *)btn{
    if (_delegate&& [_delegate respondsToSelector:@selector(CellDelegate:withActionBtn:)]) {
        [_delegate CellDelegate:self withActionBtn:btn];
    }
}


@end
