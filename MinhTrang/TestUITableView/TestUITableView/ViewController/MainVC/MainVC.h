//
//  ViewController.h
//  TestUITableView
//
//  Created by Miracle on 1/18/17.
//  Copyright © 2017 Miracle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainVC : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) NSArray *arrContent;
@end

