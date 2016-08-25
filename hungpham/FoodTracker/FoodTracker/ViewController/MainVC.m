//
//  MealVC.m
//  FoodTracker
//
//  Created by Hungpv on 8/18/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "MainVC.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MainVC () <DetailVCDelegate, UISearchResultsUpdating>

@end

@implementation MainVC 

{
    NSMutableArray *arrMeals;
    NSMutableArray *dicData;
    
    NSMutableArray *resultItems;


    
}


- (void)viewDidLoad {
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem.action = @selector(btnEditTapped);
    arrMeals = [[NSMutableArray alloc]init];
    resultItems = [[NSMutableArray alloc]init];
    
    _search = [[UISearchController alloc] initWithSearchResultsController:nil];
    _search.searchResultsUpdater = self;
    _search.dimsBackgroundDuringPresentation = NO;
    _search.searchBar.delegate = self;
    [_search.searchBar sizeToFit];
    
    self.definesPresentationContext = YES;
    
    self.tableView.tableHeaderView = _search.searchBar;
    
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

#pragma mark - search delegate

- (void) updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = searchController.searchBar.text;
    Meal *mealTem = [[Meal alloc]init];
    if (![searchString isEqualToString:@""]) {
        
        [resultItems removeAllObjects];
        for (NSInteger i = 0; i < arrMeals.count; i++) {
            mealTem = arrMeals[i];
            if ([mealTem.mealName.lowercaseString hasPrefix:searchString.lowercaseString]) {
                [resultItems addObject:mealTem];
            }
        }
    }
    [_tbvContent reloadData];
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_search.searchBar.text.length > 0) {
        return [resultItems count];
    }
    return [arrMeals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"mealcell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[Cell alloc]init];
    }
    Meal *tem = [[Meal alloc]init];
    if (_search.searchBar.text.length > 0) {
        tem = resultItems[indexPath.row];
        
    } else {
        tem = arrMeals[indexPath.row];
        
    }
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
        [self.navigationController pushViewController:newMealVC animated:YES];
    }
}

- (void)detailVC:(DetailVC *)newMealVC newMeal:(Meal *)newMeal {
    
    [arrMeals addObject:newMeal];
    [_tbvContent reloadData];
}

@end

