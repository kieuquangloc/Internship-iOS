//
//  Meal.m
//  projectA
//
//  Created by Kai Hackintosh on 8/16/16.
//  Copyright © 2016 Kai Hackintosh. All rights reserved.
//

#import "Meal.h"

@implementation Meal
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.name = dic[@"Name"];
        self.imageName = dic[@"Image"];
        self.rate = [dic[@"Rate"] integerValue];
    }
    return self;
}
@end
