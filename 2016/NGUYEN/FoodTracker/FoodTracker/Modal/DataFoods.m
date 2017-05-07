//
//  DataFoods.m
//  FoodTracker
//
//  Created by NguyenMach-MAC on 8/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "DataFoods.h"

@implementation DataFoods{
    
    NSArray  *_foodIndexTitles;
    
}

- (NSMutableDictionary*)getArrayData:(NSString *)url{
    
    _foodIndexTitles = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];

    _arrFood = [[ NSMutableArray alloc]init];
    _arrFooDic = [[NSMutableDictionary alloc]init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request    returningResponse:nil error:nil];
    NSDictionary *arrData = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
    _arrFood = arrData[@"recipes"] ;
    NSMutableArray *arrFoodSection;
    
    for (NSInteger i = 0; i<[_foodIndexTitles count]; i++) {
        
        arrFoodSection  = [[NSMutableArray alloc]init];
        
        for (NSInteger j = 0; j<[_arrFood count]; j ++) {
               NSString *titleFood =  _arrFood[j][@"title"] ;
            if ([titleFood hasPrefix:_foodIndexTitles[i]]) {
                [arrFoodSection addObject:_arrFood[j]];
            }
        }
        if (arrFoodSection.count != 0) {
            
          [_arrFooDic setObject: arrFoodSection forKey:_foodIndexTitles[i]];
        }
    

    }
    
    return _arrFooDic;
}

@end
