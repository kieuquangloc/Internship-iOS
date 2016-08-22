//
//  getData.m
//  a2
//
//  Created by Hungpv on 8/20/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "getData.h"

@implementation getData

- (void)mapData:(NSDictionary *)dic{
    if (dic) {
        _title = [dic objectForKey:@"title"];
        _image_url = [dic objectForKey:@"image_url"];
        _social_rank = [dic objectForKey:@"social_rank"];
        
    }
}

@end
