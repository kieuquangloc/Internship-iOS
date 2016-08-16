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
#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "DataFoods.h"


@interface MainVC : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)IBOutlet UITableView* tbv;




@end

