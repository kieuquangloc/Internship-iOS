//
//  DataFoods.h
//  FoodTracker
//
//  Created by NguyenMach-MAC on 8/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataFoods : NSObject

@property(nonatomic,strong) NSMutableArray *arrFood;
@property(nonatomic,strong) NSMutableDictionary *arrFooDic;
@property(nonatomic,strong) NSArray  *foodIndexTitles;

-(NSDictionary*) getArrayData:(NSString* )url;



@end
