//
//  Meal.m
//  FoodTracker
//
//  Created by HHumorous on 9/21/17.
//  Copyright © 2017 HHumorous. All rights reserved.
//

#import "Meal.h"
@interface Meal () <NSObject, NSCoding> {
}

@end

@implementation Meal

//init?(name: String, photo: UIImage?, rating: Int) {
//
//    guard !name.isEmpty else {
//        return nil
//    }
//
//    guard (rating >= 0) && (rating <= 5) else {
//        return nil
//    }
//
//    if name.isEmpty || rating < 0  {
//        return nil
//    }
//
//    self.name = name
//    self.photo = photo
//    self.rating = rating
//
//}

- (id)initMealWithName:(NSString*)name Photo:(UIImage*)img AndRating:(NSInteger)rating {
    self =[super init];
    _mealName = name;
    _imageMeal = img;
    _rating = rating;
    
    return self;
}

//- (id)init? (NSString*)name 

- (void) encodeWithCoder: (NSCoder *) encoder
{
    [encoder encodeObject:_mealName forKey:@"name"];
    [encoder encodeObject:_imageMeal forKey:@"image"];
    //[encoder encodeObject:[NSNumber numberWithInteger:_rating] forKey:@"rating"];

}

- (id)initWithCoder:(NSCoder *)aDecoder {
    NSString *name = [aDecoder decodeObjectForKey:@"name"];
    UIImage *image = [aDecoder decodeObjectForKey:@"image"];
    NSInteger rating = [aDecoder decodeObjectForKey:@"rating"];
    
    return [self initMealWithName:name Photo:image AndRating:1];
}

- (NSString *)urlFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Meal"];
    
    return documentsDirectory;
}

@end


