//
//  Food.h
//  MenuFood
//
//  Created by Quyen Dang on 8/14/16.
//  Copyright © 2016 AnhSinGum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Food : NSObject
@property(strong,nonatomic) NSString *name;
@property(assign) NSInteger rate;
@property(strong) NSString *image;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
