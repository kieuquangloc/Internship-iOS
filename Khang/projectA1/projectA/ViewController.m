//
//  ViewController.m
//  projectA
//
//  Created by Kai Hackintosh on 8/16/16.
//  Copyright © 2016 Kai Hackintosh. All rights reserved.
//

#import "ViewController.h"
#import "DataManager.h"
#import "Meal.h"
#import "AddVC.h"
#import "Cell.h"
#import "DetailVC.h"
#import <SVProgressHUD.h>
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tbvMain;
@property (strong,nonatomic) NSMutableArray *arr;
@property (nonatomic,assign) BOOL thisIsFirstLoadApp;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SVProgressHUD showWithStatus:@" Chờ tí nha !  😘 " ];
    [[DataManager shareIntance]getDataWithCallback:^{
        
        
        [_tbvMain reloadData];
        //[SVProgressHUD dismissWithDelay:3];

        
        
    }];
    [SVProgressHUD dismissWithDelay:3];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [DataManager shareIntance].foodList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        NSArray *reversedArray = [[[DataManager shareIntance].foodList reverseObjectEnumerator] allObjects];
        Meal *meal = reversedArray[indexPath.row];
    
        cell.lblMeal.text = meal.name;

      
        cell.imvMeal.image = [UIImage imageWithData:meal.imageName];
        
        if (meal.rate == 5) {
            [cell.btnStar1 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar2 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar3 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar4 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar5 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            
        }else if (meal.rate ==4 ){
            [cell.btnStar1 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar2 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar3 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar4 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar5 setHidden:YES];
            
        }
        else if (meal.rate == 3){
            [cell.btnStar1 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar2 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar3 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar4 setHidden:YES];
            [cell.btnStar5 setHidden:YES];
            
        }
        else if (meal.rate ==2 ){
            [cell.btnStar1 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar2 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar3 setHidden:YES];
            [cell.btnStar4 setHidden:YES];
            [cell.btnStar5 setHidden:YES];
            
        }
        else if (meal.rate == 1){
            [cell.btnStar1 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar2 setHidden:YES];
            [cell.btnStar3 setHidden:YES];
            [cell.btnStar4 setHidden:YES];
            [cell.btnStar5 setHidden:YES];
            
        }

//    }
        return cell;
}
- (IBAction)didTapAddNewMeal:(id)sender {
    AddVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"add"];
    [self presentViewController:vc animated:YES completion:nil];
    
    
}
- (IBAction)didTapRefresh:(id)sender {
    
    
    [[DataManager shareIntance]getDataWithCallback:^{
        [_tbvMain reloadData];
    }];
    
}
- (BOOL)ifFirstLoad{
    _thisIsFirstLoadApp = YES;
    return _thisIsFirstLoadApp;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"detail"];
    NSArray *reversedArray = [[[DataManager shareIntance].foodList reverseObjectEnumerator] allObjects];
    Meal *meal = reversedArray[indexPath.row];
    vc.strName = meal.name;
    vc.dataImage = meal.imageName;
    
    [self. navigationController pushViewController:vc animated:YES];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[DataManager shareIntance].foodList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
@end
