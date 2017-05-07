//
//  Meal.h
//  DemoAppFood
//
//  Created by ThanhSon on 8/15/16.
//  Copyright © 2016 ThanhSon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Meal : NSManagedObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * rating;
@property (nonatomic, strong) NSData * image;

@end
