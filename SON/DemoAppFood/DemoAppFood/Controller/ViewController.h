//
//  ViewController.h
//  DemoAppFood
//
//  Created by ThanhSon on 8/15/16.
//  Copyright © 2016 ThanhSon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meal.h"
#import "AddMealViewController.h"
#import "ListMealTableViewCell.h"
#import "RateView.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,RateViewDelegate>{
    BOOL isEdit;
}
@property (strong, nonatomic)NSMutableArray *listMeal;
@property (weak, nonatomic) IBOutlet UITableView *tbvListMeal;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnEdit;

@end

