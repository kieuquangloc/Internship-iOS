//
//  DataManager.m
//  MenuFood
//
//  Created by Hackintosh-DatSinGum on 8/14/16.
//  Copyright © 2016 AnhSinGum. All rights reserved.
//

#import "DataManager.h"
#import "Food.h"

@implementation DataManager

+ (DataManager *)shareIntance{
    static DataManager *instance;
    if (instance == nil) {
        instance = [[DataManager alloc] init];
    }
    return instance;
}

-(void)getData{
    
    self.foodList = [[NSMutableArray alloc] init];
    
    //lay duong dan cua file listFood.plist
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ListFood" ofType: @"plist"];
    
    
    //lay duong dan cua thu muc document
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    // tao duong dan cho file ListFood.plist trong thu muc document
    NSString *filePathDocument = [documentPath stringByAppendingPathComponent:@"ListFood.plist"];
    
    //kiem tra file listFood.plist da ton tai trong thu muc document chua
    //neu chua copy no tu bundle sang thu muc document
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePathDocument]) {
        /// ne chu ton tai roi thi copy qua
        [[NSFileManager defaultManager] copyItemAtPath:filePath toPath:filePathDocument error:nil];
    }
    
    NSArray *list = [NSArray arrayWithContentsOfFile:filePathDocument];
    for (NSDictionary *dic in list) {
        Food *item = [[Food alloc] initWithDictionary:dic];
        [_foodList addObject:item];
    }
}
-(void)saveBack{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    for (Food *item in self.foodList) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:item.name,@"Name", @(item.rate), @"Rate", item.image, @"Image", nil];
        [list addObject:dic];
    }
    //lay duong dan cua thu muc document
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePathDocument = [documentPath stringByAppendingPathComponent:@"ListFood.plist"];
    [list writeToFile:filePathDocument atomically:YES];
}
@end
