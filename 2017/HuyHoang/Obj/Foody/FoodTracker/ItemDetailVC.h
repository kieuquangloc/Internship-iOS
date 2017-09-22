//
//  ItemDetailVC.h
//  FoodTracker
//
//  Created by HHumorous on 9/20/17.
//  Copyright © 2017 HHumorous. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingStarControl.h"
#import "Meal.h"

@interface ItemDetailVC : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *mealNameTF;
@property (weak, nonatomic) IBOutlet UIImageView *imageMeal;
@property (weak, nonatomic) IBOutlet RatingStarControl *ratingStar;

@property (strong, nonatomic) Meal *food;

@property (nonatomic, strong) UIImagePickerController *imagePicker;
- (IBAction)backButton:(id)sender;

@end
