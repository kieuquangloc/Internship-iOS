//
//  Food.m
//  MenuFood
//
//  Created by Quyen Dang on 8/14/16.
//  Copyright © 2016 AnhSinGum. All rights reserved.
//

#import "Food.h"

@implementation Food
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.name = dic[@"Name"];
        self.image = dic[@"Image"];
        self.rate = [dic[@"Rate"] integerValue];
    }
    return self;
}
@end
