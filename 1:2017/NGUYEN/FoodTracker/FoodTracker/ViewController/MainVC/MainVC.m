//
//  ViewController.m
//  FoodTracker
//
//  Created by NguyenMach-MAC on 8/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "MainVC.h"
#import "MealVC.h"




@interface MainVC ()<UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate,UISearchBarDelegate,UISearchResultsUpdating>{

    NSString * _url;
    NSMutableDictionary * _arrFood;
    NSMutableArray *_searchResults;
    NSArray * _foodIndexTitles;
    AppDelegate * _appDelegate;
    UISearchController *_searchController;
    BOOL hasSearching;
}


@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
        
 
    //  [SVProgressHUD show];
    _url = @"http://food2fork.com/api/search?key=4d699174e2340160bb34e85865574bb3&q=shredded%20chicken";
    
    DataFoods *dataFoods = [[DataFoods alloc]init];
    _arrFood = [dataFoods getArrayData:_url];
    
    // sort arr _foodIndexTitles abc
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:nil ascending:YES]];
     _foodIndexTitles =  [_arrFood allKeys];
    _foodIndexTitles = [_foodIndexTitles sortedArrayUsingDescriptors:sortDescriptors];
    
    _arrFoodUser = [[NSMutableArray alloc]init];
    
    _appDelegate = [[UIApplication sharedApplication] delegate];
    
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.delegate = self;
    _searchController.searchBar.delegate = self;
    _searchController.hidesNavigationBarDuringPresentation = false;
    _searchController.dimsBackgroundDuringPresentation = NO;
    
    self.navigationItem.titleView = _searchController.searchBar;
    self.definesPresentationContext = true;
    
    

}

-(void)viewWillAppear:(BOOL)animated{
    
    //[SVProgressHUD dismissWithDelay:5];
    self.arrFoodUser =_appDelegate.arrFood;
    NSLog(@"%d",_arrFoodUser.count);
    [self.tbv reloadData];
}

#pragma mark -TableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (hasSearching) {
        return 1;
    }else{
    
    return [_foodIndexTitles count];
    }
    
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (hasSearching) {
        return @"Result Search...";
    }else{
    
        NSString *titleSection = [_foodIndexTitles objectAtIndex:section];
        return titleSection;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        if (hasSearching) {
            return _searchResults.count;
        }else{
            
            NSString *titleSection = [_foodIndexTitles objectAtIndex:section];
            NSArray *arrFoodSection = [_arrFood objectForKey:titleSection];
            
            return [arrFoodSection count];
        }
    
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FoodTrackercell *cell = [tableView dequeueReusableCellWithIdentifier:@"FoodTrackercell"];
    
    NSString *titleHerder = [_foodIndexTitles objectAtIndex:indexPath.section];
    NSArray *arrFoodFoSection = [_arrFood objectForKey:titleHerder];
    NSDictionary *dcrFood = arrFoodFoSection[indexPath.row];
//
//    if (indexPath.section == 0) {
//        
////        cell.lblName.text = ((Meal*)_arrFoodUser[indexPath.row]).title;
////        cell.imvFood.image = [UIImage imageWithData:((Meal*)_arrFoodUser[indexPath.row]).dataImage];
////        cell.ratingController.rating= ((Meal*)_arrFoodUser[indexPath.row]).social_rank;
////        
//        return cell;
//    }else{
        if (hasSearching) {
            cell.lblName.text = ((Meal*)_searchResults[indexPath.row]).title;
            cell.imvFood.image = [UIImage imageWithData:((Meal*)_searchResults[indexPath.row]).dataImage];
        }else{
            
            cell.lblName.text = dcrFood[@"title"];
            
            //load image use cocoapod
            [cell.imvFood  sd_setImageWithURL:[NSURL URLWithString:dcrFood[@"image_url"]] placeholderImage:[UIImage imageNamed:@"apple"]];
           // cell.ratingController.rating= ((Meal*)_arrFoodUser[indexPath.row]).social_rank;
        }
        
        return cell;

     //      }
    
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return _foodIndexTitles;
}
//bat su kien sort
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    //NSLog(@"%d",index);
    
    switch (index) {
        case 0:
            return 0;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 3;
            break;
        case 4:
            return 4;
            break;
        case 5:
            return 5;
            break;
        case 6:
            return 6;
            break;
        case 7:
            return 7;
            break;
        case 8:
            return 8;
            break;
            
        default:
            break;
    }
    return 0;
}





#pragma mark -TableView delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        MealVC *mealVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"MealVC"];
    
        FoodTrackercell *cellFood = [tableView dequeueReusableCellWithIdentifier:@"FoodTrackercell" forIndexPath:indexPath];
        
        NSString *titleHerder = [_foodIndexTitles objectAtIndex:indexPath.section];
        NSArray *arrFoodFoSection = [_arrFood objectForKey:titleHerder];
        NSDictionary *dcrFood = arrFoodFoSection[indexPath.row];
        
        Meal * meal = [[Meal alloc]init];
        meal.title = dcrFood[@"title"];
        meal.dataImage = UIImageJPEGRepresentation(cellFood.imvFood.image, 100);
        meal.social_rank = cellFood.ratingController.rating;
        
        _appDelegate.meal = meal;

      [self.navigationController pushViewController:mealVC animated:YES];
}



-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSString *titleFood = [_foodIndexTitles objectAtIndex:indexPath.section];
        [_arrFood[titleFood] removeObjectAtIndex:indexPath.row];
        
            [self.tbv deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationFade]; //xoa 1 row
    }
}





#pragma mask - btnActionBarItem

- (IBAction)didseclectAddFood:(id)sender {
    
    UIStoryboard *str = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    MealVC * mealVC = [str instantiateViewControllerWithIdentifier:@"MealVC"];
    mealVC.mainVC = self;
    
    
    [self.navigationController pushViewController:mealVC animated:true];
    // [self presentViewController:mealVC animated:YES completion:nil];
    
    
}

#pragma mark -seach Bar


-(void)filterContenForSearchText:(NSString*)searchText{
    
    _searchResults = [[NSMutableArray alloc]init];
    NSString *strSearchResult = [searchText lowercaseString];
    
    for (NSInteger i = 0; i<_foodIndexTitles.count; i++) {
        
        NSString *titleFood = [_foodIndexTitles objectAtIndex:i];
        NSArray *arrFoodinSection  = [_arrFood objectForKey:titleFood];
        
        for (NSInteger i = 0; i<[arrFoodinSection count]; i++) {
            NSString * strMeal = [arrFoodinSection[i][@"title"] lowercaseString];
            if([strMeal hasPrefix:strSearchResult]) {
                
                NSURL *url = [NSURL URLWithString:arrFoodinSection[i][@"image_url"]];
                NSData *data = [NSData dataWithContentsOfURL:url];
                NSInteger  ratingStrar =[arrFoodinSection[i][@"social_rank"] integerValue];
                
                Meal *meal = [[Meal alloc]initWithName: strMeal dataImage:data rating:ratingStrar];
                
                [_searchResults addObject:meal];
            }
        }

        }
             [_tbv reloadData];
    
}

//c1:event search
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

   // NSLog(@"%@",searchText);
    
    if ([searchText isEqualToString:@""]) {
        //_searchController.dimsBackgroundDuringPresentation = YES;
        hasSearching = false;
        [_tbv reloadData];
      
    }else{
        hasSearching = true;
        [self filterContenForSearchText:searchText];
    }
    

    
}
//c2:event search
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSLog(@"%@",searchController.searchBar.text);

}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    hasSearching= true;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    hasSearching = false;
    [_tbv reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    hasSearching = false;
    [_tbv reloadData];
}
//





@end
