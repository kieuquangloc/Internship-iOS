//
//  ViewController.h
//  FoodTracker
//
//  Created by Hungpv on 8/18/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meal.h"
#import "RatingControl.h"
@class DetailVC;

@protocol DetailVCDelegate <NSObject>

@required
- (void)detailVC:(DetailVC *)newMealVC newMeal:(Meal *)newMeal;

@end


@interface DetailVC: UIViewController

@property (weak, nonatomic) IBOutlet UITextField *tfMealName;
@property (weak, nonatomic) IBOutlet UIImageView *ivPhoto;
@property (weak, nonatomic) IBOutlet RatingControl *viRate;
@property (strong, nonatomic) NSData *dataImg;


@property (strong, nonatomic) id<DetailVCDelegate> delegate;

@end

