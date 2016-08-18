//
//  MealVC.h
//  FoodTracker
//
//  Created by NguyenMach-MAC on 8/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "RatingController.h"
#import "MainVC.h"
#import "Meal.h"

@interface MealVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *tfContent;
@property (weak, nonatomic) IBOutlet UIImageView *imvFood;
@property(weak, nonatomic)  IBOutlet RatingController * ratingControl;

@property (strong , nonatomic) MainVC  *mainVC;
@property (strong, nonatomic) Meal *currentMeal;

@property (nonatomic,weak) NSMutableArray *arr;
@end
