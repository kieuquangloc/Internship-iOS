//
//  ListMealTableViewCell.h
//  DemoAppFood
//
//  Created by ThanhSon on 8/15/16.
//  Copyright © 2016 ThanhSon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"

@interface ListMealTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgMeal;
@property (weak, nonatomic) IBOutlet UILabel *lblNameMeal;
@property (weak, nonatomic) IBOutlet RateView *viewRatting;



@end
