//
//  FoodTVCell.h
//  MenuFood
//
//  Created by Hackintosh-DatSinGum on 8/14/16.
//  Copyright © 2016 AnhSinGum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *avartaImage;

@property (weak, nonatomic) IBOutlet UIView *rateView;
@end
