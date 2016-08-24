//
//  ViewController.h
//  FoodTracker
//
//  Created by NguyenMach-MAC on 8/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meal.h"
#import "FoodTrackercell.h"
#import "DataFoods.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppDelegate.h"




@interface MainVC : UIViewController

@property(nonatomic,weak)IBOutlet UITableView *tbv;

@property(nonatomic,weak) NSMutableArray *arrFoodUser;









@end

