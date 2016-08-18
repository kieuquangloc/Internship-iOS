//
//  ViewController.m
//  FoodTracker
//
//  Created by NguyenMach-MAC on 8/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "MainVC.h"
#import "MealVC.h"



@interface MainVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSString * _url;
@property(nonatomic,strong) NSMutableArray * _arrFood;
@property(nonatomic,strong) AppDelegate * appDelegate;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  [SVProgressHUD show];
    __url = @"http://food2fork.com/api/search?key=4d699174e2340160bb34e85865574bb3&q=shredded%20chicken";
    
    DataFoods *dataFoods = [[DataFoods alloc]init];
    __arrFood = [dataFoods getArrayData:__url];
    _arrFoodUser = [[NSMutableArray alloc]init];
    
    _appDelegate = [[UIApplication sharedApplication] delegate];
    
    
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
        return __arrFood.count;
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
        
        cell.lblName.text = __arrFood[indexPath.row][@"title"];
        
        //load image use cocoapod
        [cell.imvFood  sd_setImageWithURL:[NSURL URLWithString:__arrFood[indexPath.row][@"image_url"]] placeholderImage:[UIImage imageNamed:@"apple"]];
        
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
        meal.title = __arrFood[indexPath.row][@"title"];
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




@end
