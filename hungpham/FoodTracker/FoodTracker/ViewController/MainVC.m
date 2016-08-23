//
//  MealVC.m
//  FoodTracker
//
//  Created by Hungpv on 8/18/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "MainVC.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MainVC () <DetailVCDelegate>

@end

@implementation MainVC 

{
    NSMutableArray *arrMeals;
    NSMutableArray *dicData;
    
    Meal *aMeal;
    
}

//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    arrMeals = [[NSMutableArray alloc]init];
//    aMeal = [[Meal alloc]init];
//    //[arrMeals addObject:@"B"];
//    [self loadSamples];
//}

- (void)viewDidLoad {
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem.action = @selector(btnEditTapped);
    arrMeals = [[NSMutableArray alloc]init];
    
    [self loadSamples];
}

- (void)loadSamples {
    UIImage *photo1 = [UIImage imageNamed:@"meal1"];
    NSData *data1 = UIImageJPEGRepresentation(photo1, 100);
    Meal *m1 = [[Meal alloc]initWithData:@"Meal 1" Image:data1 Rating: 2];
    [arrMeals addObject:m1];
    
    UIImage *photo2 = [UIImage imageNamed:@"meal2"];
    NSData *data2 = UIImageJPEGRepresentation(photo2, 100);
    Meal *m2 = [[Meal alloc]initWithData:@"Meal 2" Image:data2 Rating:4];
    [arrMeals addObject:m2];
    
    UIImage *photo3 = [UIImage imageNamed:@"meal3"];
    NSData *data3 = UIImageJPEGRepresentation(photo3, 100);
    Meal *m3 = [[Meal alloc]initWithData:@"Meal 3" Image:data3 Rating:5];
    [arrMeals addObject:m3];
    
}

- (void)btnEditTapped {
    if (_tbvContent.editing) {
        _tbvContent.editing = NO;
        self.navigationItem.leftBarButtonItem.title = @"Edit";
    } else {
        _tbvContent.editing = YES;
        self.navigationItem.leftBarButtonItem.title = @"Done";
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrMeals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"mealcell" forIndexPath:indexPath];
    
    Meal *tem = [[Meal alloc]init];
    tem = arrMeals[indexPath.row];
    cell.lblName.text = tem.mealName;
    cell.ivMealPoto.image = [UIImage imageWithData:tem.imgData];
    cell.viRating.rating = tem.stars;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100.f;
    }
    return 0.0;
}
#pragma mark - Actions



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [arrMeals removeObjectAtIndex:indexPath.row];
        [_tbvContent deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [_tbvContent reloadData];
    }

}

#pragma mark - Meal delegate

- (IBAction)btnAdd:(UIBarButtonItem *)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailVC *newMealVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    newMealVC.delegate = self;
    
    if (newMealVC) {
        //[self.navigationController showViewController:newMealVC sender:self];
        [self.navigationController pushViewController:newMealVC animated:YES];
    }
}

- (void)detailVC:(DetailVC *)newMealVC newMeal:(Meal *)newMeal {
    
    [arrMeals addObject:newMeal];
    [_tbvContent reloadData];
}

@end








//- (void)getDataFromServer {
//    // 1
//    NSString *dataUrl = @"http://food2fork.com/api/search?key=4d699174e2340160bb34e85865574bb3&q=shredded%20chicken";
//    NSURL *url = [NSURL URLWithString:dataUrl];
//    NSString *strUrl = [[NSString stringWithString:@""] mutableCopy];
//   // NSArray *arrUrl = [NSArray array];
//
//    //SDWebImageManager *manager = [SDWebImageManager sharedManager];
//
//    // 2
//    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
//                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                                              if (data) {
//                                                  NSDictionary *jsData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//
//                                                  dicData = [jsData[@"recipes"] mutableCopy];
//
//                                                  for (NSInteger i = 0; i < dicData.count; i++) {
//                                                      //strUrl = [dicData[i][@"image_url"] mutableCopy];
//
//                                                      [aMeal.imgData sd_setImageWithURL:[NSURL URLWithString:@"https://graph.facebook.com/olivier.poitrey/picture"]
//                                                                   placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]
//                                                                            options:SDWebImageRefreshCached];
//                                                                                                             //sd_setImageWithURL:[NSURL URLWithString:[dicData[i][@"image_url"] mutableCopy]] placeholderImage:[aMeal.ima imageNamed:@"apple"];
//                                                      //                                                      [aMeal.imgData sd_setImageWithURL:[NSURL URLWithString:[dicData[0][@"image_url"] mutableCopy]] placeholderImage:[UIImage imageNamed:@"apple"];
//                                                  }
//                                                  //NSString *a = arrData[0][@"social_rank"];
//                                              }
//
//                                          }];
//    [downloadTask resume];
//    // 3
//
//}
