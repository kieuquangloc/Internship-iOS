//
//  AppDelegate.h
//  FoodTracker
//
//  Created by NguyenMach-MAC on 8/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meal.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *arrFood;
@property (strong, nonatomic) Meal *meal;
@property (assign, nonatomic) BOOL hasEdit;


@end

