//
//  Meal.h
//  FoodTracker
//
//  Created by Hungpv on 8/18/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Meal : NSObject 

@property (strong, nonatomic) NSString  *mealName;
@property (strong, nonatomic) NSData   *imgData;
@property (assign) NSInteger stars;

- (instancetype)initWithData:(NSString*)mealName Image:(NSData *)imgData Rating:(NSInteger)stars;

- (void) setData:(NSString*)mealName Image:(NSData *)imgData Rating:(NSInteger)stars;

- (void)getDataFromDictionary:(NSDictionary *)dic;

@end