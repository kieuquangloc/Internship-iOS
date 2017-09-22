//
//  Meal.h
//  FoodTracker
//
//  Created by HHumorous on 9/21/17.
//  Copyright © 2017 HHumorous. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <os/log.h>

@class Meal;

@interface Meal : NSObject

@property (strong, nonatomic) NSString *mealName;
@property (strong, nonatomic) UIImage *imageMeal;
@property (nonatomic, assign) NSInteger rating;

@property (strong, nonatomic) NSString *urlFile;

- (id)initMealWithName:(NSString*)name Photo:(UIImage*)img AndRating:(NSInteger)rating;

@end

@interface listMeal : NSObject

@property (strong, nonatomic) NSMutableArray *list;

@end


