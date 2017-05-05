//
//  AddViewController.h
//  MenuFood
//
//  Created by Quyen Dang on 8/14/16.
//  Copyright © 2016 AnhSinGum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *imageLabel;
@property (weak, nonatomic) IBOutlet UIStepper *rateStepper;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@end
