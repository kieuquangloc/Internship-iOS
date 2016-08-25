//
//  Meal.m
//  FoodTracker
//
//  Created by Hungpv on 8/18/16.
//  Copyright © 2016 hungpham. All rights reserved.
//


#import "Meal.h"

@implementation Meal

- (instancetype)initWithData:(NSString *)mealName Image:(NSData *)imgData Rating:(NSInteger)star {
    
    self.mealName = mealName;
    self.imgData = imgData;
    self.stars = star;
    self = [super init];
    
    if (self.mealName.length == 0 || self.stars < 0) {
        return nil;
    }
    
    return self;
}

- (void)setData:(NSString *)mealName Image:(NSData *)imgData Rating:(NSInteger)stars {
    if (self.mealName.length == 0 || self.stars < 0) {
        return;
    }
    self.mealName = mealName;
    self.imgData = imgData;
    self.stars = stars;

}

- (void)getDataFromDictionary:(NSDictionary *)dic {
    //self.mealName = [dic objectForKey:]
}

@end