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
    NSMutableArray * _arrFood;
    NSMutableArray *_searchResults;
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

#pragma mask -TableViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        
        if (hasSearching) {
            return _searchResults.count;
        }else{
        return _arrFood.count;
        }
    }else if (section == 0){
        
        return _arrFoodUser.count;
    }
    
    
    return 0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return @"Foods User Add";
    }else{
        
        return @"Foods on Server";
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FoodTrackercell *cell = [tableView dequeueReusableCellWithIdentifier:@"FoodTrackercell"];
    
    if (indexPath.section == 1) {
        
        if (hasSearching) {
            
            
            cell.lblName.text = ((Meal*)_searchResults[indexPath.row]).title;
            cell.imvFood.image = [UIImage imageWithData:((Meal*)_searchResults[indexPath.row]).dataImage];
         
            
        }else{
        
        cell.lblName.text = _arrFood[indexPath.row][@"title"];
        
        //load image use cocoapod
        [cell.imvFood  sd_setImageWithURL:[NSURL URLWithString:_arrFood[indexPath.row][@"image_url"]] placeholderImage:[UIImage imageNamed:@"apple"]];
        }
        
        return cell;
        
    }else{
        
        
        cell.lblName.text = ((Meal*)_arrFoodUser[indexPath.row]).title;
        cell.imvFood.image = [UIImage imageWithData:((Meal*)_arrFoodUser[indexPath.row]).dataImage];
        return cell;
    }
    
}


#pragma mask -TableView delegate


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MealVC *mealVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"MealVC"];
    
    if (indexPath.section == 0) {
        _appDelegate.meal = _arrFoodUser[indexPath.row];
        //mealVC.tfContent.text = ((Meal*)_arrFoodUser[indexPath.row]).title;
        [self.navigationController pushViewController:mealVC animated:YES];
        
    }else if (indexPath.section == 1){
        
        FoodTrackercell *cellFood = [tableView dequeueReusableCellWithIdentifier:@"FoodTrackercell" forIndexPath:indexPath];
        
        Meal * meal = [[Meal alloc]init];
        meal.title = _arrFood[indexPath.row][@"title"];
        meal.dataImage = UIImageJPEGRepresentation(cellFood.imvFood.image, 100);
        meal.social_rank = cellFood.ratingController.rating;
        
        _appDelegate.meal = meal;
        [self.navigationController pushViewController:mealVC animated:YES];
    }
}

//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return UITableViewCellEditingStyleNone;
//}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (indexPath.section == 0) {
            [_arrFoodUser removeObjectAtIndex:indexPath.row];
            
            [self.tbv deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationFade]; //xoa 1 row
            
            
        }
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
    for (NSInteger i = 0; i<_arrFood.count; i++) {
        
        NSString * strMeal = [_arrFood[i][@"title"] lowercaseString];
        if([strMeal hasPrefix:strSearchResult]) {
            
            NSURL *url = [NSURL URLWithString:_arrFood[i][@"image_url"]];
            NSData *data = [NSData dataWithContentsOfURL:url];
            NSInteger  ratingStrar =[_arrFood[i][@"social_rank"] integerValue];
            
            Meal *meal = [[Meal alloc]initWithName: strMeal dataImage:data rating:ratingStrar];
            
            [_searchResults addObject:meal];
        }
    }
    [_tbv reloadData];
    
}

//c1:event search
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

   // NSLog(@"%@",searchText);
    
    [self filterContenForSearchText:searchText];
    
    if (![searchText isEqualToString:@""]) {
       _searchController.dimsBackgroundDuringPresentation = NO;
      
    }
    

    
}
//c2:event search
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSLog(@"%@",searchController.searchBar.text);

}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    hasSearching= true;
  //  [_tbv reloadData];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    hasSearching = false;
    [_tbv reloadData];
}
//
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    hasSearching = false;
    [_tbv reloadData];
}
//





@end
