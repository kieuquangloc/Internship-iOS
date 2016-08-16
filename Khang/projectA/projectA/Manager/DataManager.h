//
//  DataManager.h
//  projectA
//
//  Created by Kai Hackintosh on 8/16/16.
//  Copyright © 2016 Kai Hackintosh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject
+(DataManager *)shareIntance;
@property (strong) NSMutableArray *foodList;
-(void)getDataWithCallback:(void(^)(void))callback;
-(void)saveBack;
@end
