//
//  Meal.h
//  projectA
//
//  Created by Kai Hackintosh on 8/16/16.
//  Copyright © 2016 Kai Hackintosh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Meal : NSObject
@property(strong,nonatomic) NSString *name;
@property(assign) NSInteger rate;
@property(strong) NSData *dataImg;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
