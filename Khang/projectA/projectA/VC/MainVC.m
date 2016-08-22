//
//  ViewController.m
//  projectA
//
//  Created by Kai Hackintosh on 8/16/16.
//  Copyright © 2016 Kai Hackintosh. All rights reserved.
//

#import "MainVC.h"
#import "DataManager.h"
#import "Meal.h"
#import "AddVC.h"
#import "Cell.h"
#import "DetailVC.h"
#import <SVProgressHUD.h>

@interface MainVC ()
<UITableViewDelegate,
UITableViewDataSource,
UISearchBarDelegate,
UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tbvMain;
@property (strong,nonatomic) NSMutableArray *arr;

@property (strong,nonatomic) UISearchDisplayController *searchDislayController;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong,nonatomic) NSMutableArray *arrResults;

@property (strong,nonatomic) UISegmentedControl *segControl;
@property (strong,nonatomic) NSArray *arrSortDesciptors;
@property (strong,nonatomic) NSArray *arrSorted;
@property (strong,nonatomic) NSSortDescriptor *sorter;
@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arrResults = [[NSMutableArray alloc]init];
    [_searchBar setHidden:YES];
    
    
}


-(void) viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    [[DataManager shareIntance]getDataWithCallback:^{
        [SVProgressHUD showWithStatus:@" Chờ tí nha !  😘 " ];
        [[DataManager shareIntance] saveBack];
        [_tbvMain reloadData];
        [SVProgressHUD dismissWithDelay:3];
    }];
   
    
}

//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    [_searchBar setHidden:NO];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - BUTTON NAVIGATION

- (IBAction)didTapSearch:(id)sender {
    
    [_searchBar setHidden:NO];
    [_searchBar becomeFirstResponder];
    
    
    
}

- (IBAction)didTapAddNewMeal:(id)sender {
    AddVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"add"];
    [self presentViewController:vc animated:YES completion:nil];
    
    
}
- (IBAction)didTapRefresh:(id)sender {
    
    [SVProgressHUD showWithStatus:@" Chờ tí nha !  😘 " ];
    [[DataManager shareIntance]getDataWithCallback:^{
       
       [[DataManager shareIntance] saveBack];
        [_tbvMain reloadData];

        [SVProgressHUD dismissWithDelay:10];
        
    }];
    
    
}



#pragma mark - TABLEVIEW

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"detail"];
    
    if (tableView == _tbvMain) {
        Meal *meal = [DataManager shareIntance].foodList[indexPath.row];
        vc.strName = meal.name;
        vc.dataImg = meal.dataImg;
    }else if (tableView == _searchDislayController.searchResultsTableView || YES){
        Meal *meal = _arrResults[indexPath.row];
        vc.strName = meal.name;
        vc.dataImg = meal.dataImg;
    }
    
    
    [self. navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        [[DataManager shareIntance].foodList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [[DataManager shareIntance]saveBack];
    }
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _tbvMain) {
        return [DataManager shareIntance].foodList.count;
    }else{
        return _arrResults.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tbvMain) {
        
       
        
        Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        Meal *meal = [DataManager shareIntance].foodList[indexPath.row];
        cell.lblMeal.text = meal.name;
        
        if ([meal.dataImg isKindOfClass:[NSData class]]){
            cell.imvMeal.image = [UIImage imageWithData:meal.dataImg];
            
        }
        
        if (meal.rate == 5)
        {
            [cell.btnStar1 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar2 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar3 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar4 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar5 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            
        }
        else if (meal.rate ==4 )
        {
            [cell.btnStar1 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar2 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar3 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar4 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar5 setHidden:YES];
            
        }
        else if (meal.rate == 3)
        {
            [cell.btnStar1 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar2 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar3 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar4 setHidden:YES];
            [cell.btnStar5 setHidden:YES];
            
        }
        else if (meal.rate ==2 )
        {
            [cell.btnStar1 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar2 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar3 setHidden:YES];
            [cell.btnStar4 setHidden:YES];
            [cell.btnStar5 setHidden:YES];
            
        }
        else if (meal.rate == 1)
        {
            [cell.btnStar1 setImage:[UIImage imageNamed:@"mark-as-favorite-star-2"] forState:UIControlStateNormal];
            [cell.btnStar2 setHidden:YES];
            [cell.btnStar3 setHidden:YES];
            [cell.btnStar4 setHidden:YES];
            [cell.btnStar5 setHidden:YES];
            
        }
        
        
        return cell;
    }else if(tableView == _searchDislayController.searchResultsTableView|| YES){
        UITableViewCell *cell = [UITableViewCell new];
        Meal *meal = _arrResults[indexPath.row];
        cell.textLabel.text = meal.name;
        if ([meal.dataImg isKindOfClass:[NSData class]]){
            cell.imageView.image = [UIImage imageWithData:meal.dataImg];
            
        }
        [tableView setAlpha:0.9];
        [tableView setBackgroundColor:[UIColor blackColor]];
        
        cell.backgroundColor = [UIColor blackColor];
        cell.textLabel.textColor = [UIColor redColor];
      
        return cell;
    }
    
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    if(cell.layer.position.x != 0){
        cell.layer.position = CGPointMake(0, cell.layer.position.y);
    }
    
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.7];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}

#pragma mark - SearchDisplayController


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
   
    _searchBar.keyboardAppearance = UIKeyboardAppearanceDark;
     _searchBar = searchBar ;
    return YES;
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [_arrResults removeAllObjects];
    for (Meal *meal in [DataManager shareIntance].foodList) {
        NSString *str = meal.name;
        if ([[[self encodingStringWithVietnamese:str]lowercaseString] containsString:[[self encodingStringWithVietnamese:searchText]lowercaseString]]) {
            [_arrResults addObject:meal];
        }
    }
    _searchBar.keyboardAppearance = UIKeyboardAppearanceDark;
    //[_tbvMain reloadData];
}

- (NSString *)encodingStringWithVietnamese:(NSString *)vietnam{
    NSString *str = [vietnam stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    str = [str lowercaseString];
    str = [str stringByReplacingOccurrencesOfString:@"đ" withString:@"d"];
    return str;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [_searchBar setHidden:YES];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

@end
