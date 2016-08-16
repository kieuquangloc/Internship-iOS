//
//  Meal.h
//  FoodTracker
//
//  Created by NguyenMach-MAC on 8/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Meal : NSObject

@property(nonatomic,assign)NSInteger social_rank;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong) NSData*  dataImage;

//-(void)initWithName;

@end
