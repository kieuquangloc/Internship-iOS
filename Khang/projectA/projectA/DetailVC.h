//
//  DetailVC.h
//  projectA
//
//  Created by Kai Hackintosh on 8/16/16.
//  Copyright © 2016 Kai Hackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imvBackgound;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) NSData *dataImage;
@property (strong, nonatomic) NSString *strName;
@end
