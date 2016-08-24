//
//  AddVC.h
//  projectA
//
//  Created by Kai Hackintosh on 8/16/16.
//  Copyright © 2016 Kai Hackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UIImageView *imvMeal;


@property (weak, nonatomic) IBOutlet UIButton *btnStar1;
@property (weak, nonatomic) IBOutlet UIButton *btnStar2;
@property (weak, nonatomic) IBOutlet UIButton *btnStar3;
@property (weak, nonatomic) IBOutlet UIButton *btnStar4;
@property (weak, nonatomic) IBOutlet UIButton *btnStar5;

@property (assign,nonatomic) NSInteger rating;
@property (strong,nonatomic) NSData *dataImage;
@property (strong,nonatomic) NSString *strImageName;
@end
