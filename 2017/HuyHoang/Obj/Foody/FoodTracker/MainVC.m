//
//  ViewController.m
//  FoodTracker
//
//  Created by HHumorous on 9/20/17.
//  Copyright © 2017 HHumorous. All rights reserved.
//

#import "MainVC.h"

@interface MainVC () <UITableViewDataSource, UITableViewDelegate> {

}

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _mealArr = [[NSMutableArray alloc]init];
//
//
//    if let savedFoods = loadFoods() {
//        foods += savedFoods
//    }
//    else {
//        loadSampleMeals()
//    }
    // Do any additional setup after loading the view, typically from a nib.
    [self loadFoods];
    [self saveFoods];
    _mealArr = [self loadFoods];
    [_tableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _mealArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    Meal *data = _mealArr[indexPath.row];
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell"];
    
    cell.mealName.text = data.mealName;
    cell.imgView1.image = data.imageMeal;
    cell.ratingStar.rating = data.rating;
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_mealArr removeObjectAtIndex:indexPath.row];
        [self saveFoods];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
     } else if (editingStyle == UITableViewCellEditingStyleInsert){
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemDetailVC *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemDetailVC"];
    Meal *currentMeal = _mealArr[indexPath.row];
    detailView.food = currentMeal;
    [self.navigationController pushViewController:detailView animated:YES];
}

//@IBAction func unwindToMealList(sender: UIStoryboardSegue) {
//    if let sourceViewController = sender.source as? ItemDetailVC, let food = sourceViewController.food {
//
//        if let selectedIndexPath = mealTableView.indexPathForSelectedRow {
//            foods[selectedIndexPath.row] = food
//            mealTableView.reloadRows(at: [selectedIndexPath], with: .none)
//        }
//        else {
//            let newIndexPath = IndexPath(row: foods.count, section: 0)
//
//            foods.append(food)
//            mealTableView.insertRows(at: [newIndexPath], with: .automatic)
//        }
//
//        saveFoods()
//    }
//}

//- (void)unwindToMealList:(UIStoryboardSegue *)sender {
//    Meal *meal = [[Meal alloc] init];
//
//    ItemDetailVC *sourceVC = sender.sourceViewController;
//    NSMutableArray *meal = sourceVC self;
//
//
//}
//MARK: Private Methods

-(void)loadSampleMeals {
    UIImage *photo1 = [UIImage imageNamed:@"meal1"];
    UIImage *photo2 = [UIImage imageNamed:@"meal2"];
    
    Meal *meal1 = [[Meal alloc]initMealWithName:@"Meal1" Photo:photo1 AndRating:4];
    Meal *meal2 = [[Meal alloc]initMealWithName:@"Meal2" Photo:photo2 AndRating:3];
    
    [_mealArr addObjectsFromArray:@[meal1,meal2]];
}

-(void)saveFoods {
    Meal *file = [[Meal alloc] init];
    [NSKeyedArchiver archiveRootObject:_mealArr toFile:file.urlFile];
}

- (NSMutableArray*)loadFoods {
    
    Meal *a = [[Meal alloc] init];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:a.urlFile];
}


- (IBAction)addMealButton:(id)sender {
    ItemDetailVC *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemDetailVC"];
    [self.navigationController pushViewController:detailView animated:YES];
    
}
@end
