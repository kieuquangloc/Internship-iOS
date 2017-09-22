//
//  ViewController.h
//  FoodTracker
//
//  Created by HHumorous on 9/20/17.
//  Copyright © 2017 HHumorous. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <os/log.h>
#import "Meal.h"
#import "ItemCell.h"
#import "ItemDetailVC.h"

@interface MainVC : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<Meal*> *mealArr;
- (IBAction)addMealButton:(id)sender;


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
@end

