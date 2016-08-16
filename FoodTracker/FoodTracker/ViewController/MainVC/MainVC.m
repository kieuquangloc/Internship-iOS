//
//  ViewController.m
//  FoodTracker
//
//  Created by NguyenMach-MAC on 8/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "MainVC.h"
#import "MealVC.h"


@interface MainVC ()

@property(nonatomic,strong)NSString * _url;
@property(nonatomic,strong) NSMutableArray * _arrFood;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
      [SVProgressHUD show];
    __url = @"http://food2fork.com/api/search?key=4d699174e2340160bb34e85865574bb3&q=shredded%20chicken";
    
    DataFoods *dataFoods = [[DataFoods alloc]init];
    
    __arrFood = [dataFoods getArrayData:__url];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{

 
    [SVProgressHUD dismissWithDelay:5];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
          return __arrFood.count;
    }else if (section == 0){
    
       return 0;
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

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [__arrFood removeObjectAtIndex:indexPath.row];
        
        [self.tbv deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationFade]; //xoa 1 row
        
        
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
    
        return cell;
    }
    
}
- (IBAction)didseclectAddFood:(id)sender {
    
    
    UIStoryboard *str = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    MealVC * meal = [str instantiateViewControllerWithIdentifier:@"MealVC"];
   
    [self.navigationController pushViewController:meal animated:true];
    
    
}










@end
