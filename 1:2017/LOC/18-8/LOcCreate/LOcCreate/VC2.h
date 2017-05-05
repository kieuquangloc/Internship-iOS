//
//  VC2.h
//  LOcCreate
//
//  Created by QuangLoc on 8/18/16.
//  Copyright © 2016 QuangLoc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewRate.h"

@class VC2;

@protocol VC2Delegate <NSObject>

@required
- (void)vC2:(VC2 *)vc2 didPressOnViewRate:(UIView*)view withData:(NSArray*)arrData;

@optional
- (void)vC2:(VC2 *)vc2 didLongPressOnViewRate:(UIView*)view;

@end



@interface VC2 : UIViewController



@property (nonatomic, strong) id<VC2Delegate> delegate;




@property (nonatomic, weak) IBOutlet ViewRate *vRate;

@property (nonatomic, strong) NSString *strTitle;

@property (nonatomic, strong) NSArray *arrData;

@end
