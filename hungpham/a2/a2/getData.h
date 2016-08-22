//
//  getData.h
//  a2
//
//  Created by Hungpv on 8/20/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface getData : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *image_url;
@property (strong, nonatomic) NSString *social_rank;

- (void)mapData:(NSDictionary *)dic;

@end
