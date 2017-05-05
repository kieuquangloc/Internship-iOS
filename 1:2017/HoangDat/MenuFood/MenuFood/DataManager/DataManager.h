//
//  DataManager.h
//  MenuFood
//
//  Created by Hackintosh-DatSinGum on 8/14/16.
//  Copyright © 2016 AnhSinGum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject
+(DataManager *)shareIntance;
@property (strong) NSMutableArray *foodList;
-(void)getData;
-(void)saveBack;
@end
