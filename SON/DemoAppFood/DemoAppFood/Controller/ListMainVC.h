//
//  ListMainVC.h
//  DemoAppFood
//
//  Created by ThanhSon on 8/15/16.
//  Copyright © 2016 ThanhSon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meal.h"
#import "AddMealVC.h"
#import "MealCell.h"
#import "RateView.h"

@interface ListMainVC : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tbvListMeal;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnEdit;
@property (strong, nonatomic) NSMutableArray *listMeal;

- (IBAction)btnAddMeal:(id)sender;

@end

