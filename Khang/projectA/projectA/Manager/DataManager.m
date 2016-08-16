//
//  DataManager.m
//  projectA
//
//  Created by Kai Hackintosh on 8/16/16.
//  Copyright © 2016 Kai Hackintosh. All rights reserved.
//

#import "DataManager.h"
#import "Meal.h"
@implementation DataManager
+(DataManager *)shareIntance{
    static DataManager *instance;
    if (instance == nil) {
        instance = [[DataManager alloc] init];
    }
    return instance;
}
-(void)saveBack{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    for (Meal *meal in self.foodList) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:meal.name,@"Name", @(meal.rate), @"Rate", meal.imageName, @"Image", nil];
        [list addObject:dic];
    }
    //lay duong dan cua thu muc document
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePathDocument = [documentPath stringByAppendingPathComponent:@"ListFood.plist"];
    [list writeToFile:filePathDocument atomically:YES];
}
-(void)getDataWithCallback:(void(^)(void))callback{
    
    self.foodList = [[NSMutableArray alloc] init];
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ListFood" ofType: @"plist"];
    
    NSString *filePathDocument = [documentPath stringByAppendingPathComponent:@"ListFood.plist"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:filePathDocument]) {
       
        [[NSFileManager defaultManager] copyItemAtPath:filePath toPath:filePathDocument error:nil];
    }
    
    NSArray *list = [NSArray arrayWithContentsOfFile:filePathDocument];
    for (NSDictionary *dic in list) {
        Meal *item = [[Meal alloc] initWithDictionary:dic];
        [self.foodList addObject:item];
    }
    NSLog(@"%ld",self.foodList.count);
    if (callback) {
        callback();
    }
}

@end
