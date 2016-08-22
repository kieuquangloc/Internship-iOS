//
//  Meal.m
//  FoodTracker
//
//  Created by NguyenMach-MAC on 8/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "Meal.h"

@implementation Meal

- (instancetype)initWithName:(NSString *)title dataImage:(NSData *)dataImage rating:(NSInteger)social_rank{
 
    self.title = title;
    self.dataImage = dataImage;
    self.social_rank = social_rank;
    
    return self;
}



@end
