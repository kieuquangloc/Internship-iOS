//
//  MealVC.h
//  FoodTracker
//
//  Created by Hungpv on 8/18/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meal.h"
#import "Cell.h"
#import "DetailVC.h"
//#import <SDWebImage/UIImageView+WebCache.h>
#import "SDWebImage/SDWebImageDownloader.h"
//#import "newMeal.h"


@class MainVC;

@interface MainVC : UITableViewController <UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UITableView *tbvContent;
@property (strong, nonatomic) NSString *name ;
@property (strong, nonatomic) NSData *dataImg;
@property (assign, nonatomic) NSInteger rating;

@property (strong, nonatomic) UISearchController *search;
@end
