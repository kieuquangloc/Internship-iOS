//
//  Cell.h
//  TestUITableView
//
//  Created by Miracle on 1/18/17.
//  Copyright © 2017 Miracle. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Cell;

@protocol CellDelegate <NSObject>
@required
- (void)cell:(Cell*)cell didBeginEditting:(UITextField*)tf;
- (void)cell:(Cell*)cell didEndEditting:(UITextField*)tf;
- (void)cell:(Cell*)cell didChangeString:(NSString*)tf inTextfield:(UITextField*)tf;

- (void)cell:(Cell*)cell didPressReturn:(UITextField*)tf;

@end



@interface Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;

@property (weak, nonatomic) IBOutlet UILabel *lblNameCompany;

@property (weak, nonatomic) IBOutlet UITextField *tfContent;
@property (weak, nonatomic) IBOutlet UILabel *lblRegistKey;
@property (weak, nonatomic) IBOutlet UITextField *tfKey1;
@property (weak, nonatomic) IBOutlet UITextField *tfKey2;
@property (weak, nonatomic) IBOutlet UITextField *tfKey3;
@property (weak, nonatomic) IBOutlet UITextField *tfKey4;
@property (weak, nonatomic) IBOutlet UIButton *btnRegist;
@property (weak, nonatomic) IBOutlet UILabel *lblWarning;

@property (weak, nonatomic) id<CellDelegate> delegate;

@end
