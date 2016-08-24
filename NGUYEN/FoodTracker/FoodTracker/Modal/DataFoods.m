//
//  DataFoods.m
//  FoodTracker
//
//  Created by NguyenMach-MAC on 8/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "DataFoods.h"

@implementation DataFoods

- (NSMutableArray*)getArrayData:(NSString *)url{

    _arrFood = [[ NSMutableArray alloc]init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request    returningResponse:nil error:nil];
    NSDictionary *arrData = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
    _arrFood = arrData[@"recipes"] ;
    
    return _arrFood;
}

@end
