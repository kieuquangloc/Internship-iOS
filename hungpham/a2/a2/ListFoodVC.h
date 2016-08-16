//
//  BaseTableViewController.h
//  a2
//
//  Created by Hungpv on 8/16/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cell.h"
#import <SDWebImage/UIImageView+WebCache.h>
//#import <SVProgressHUD/SVProgressHUD.h>

@interface ListFoodVC: UIViewController

@property(nonatomic,strong) NSString * url;
@property(nonatomic,strong) NSMutableArray * arr;
@property(nonatomic,weak)IBOutlet UITableView* tbvContent;

@end
