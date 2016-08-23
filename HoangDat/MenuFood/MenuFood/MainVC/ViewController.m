//
//  ViewController.m
//  MenuFood
//
//  Created by Hackintosh-DatSinGum on 8/14/16.
//  Copyright © 2016 AnhSinGum. All rights reserved.
//

#import "ViewController.h"
#import "DataManager.h"
#import "FoodTVCell.h"
#import "Food.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AddViewController.h"
@interface ViewController () <UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate,UISearchResultsUpdating>
@property (weak, nonatomic) IBOutlet UITableView *foodTBV;
@property (strong, nonatomic) NSMutableArray *mangSearch;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //dang ky delegate
  
    self.foodTBV.delegate = self;
    // dang ky datasource
    self.foodTBV.dataSource = self;
}

#pragma mark Tableview delegate
// quy dinh so section cua table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_search.text.length > 0) {
        return _mangSearch.count;
    }else{
        return [DataManager shareIntance].foodList.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /// quy dinh noi dung cua tung cell
    
    
    if (_search.text.length <= 0) {
        Food *item = [DataManager shareIntance].foodList[indexPath.row];
        FoodTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FoodCell"];
        cell.lblName.text = item.name;
        
        
        for (id view in [cell.rateView subviews]) {
            [view removeFromSuperview];
        }
        
        float starWi = cell.rateView.frame.size.width / 5;
        for (NSInteger i = 0; i < 5; i++) {
            if (i <= item.rate - 1 ) {
                UIImageView *startView = [[UIImageView alloc] initWithFrame:CGRectMake(i*starWi, 0, starWi, starWi)];
                startView.image = [UIImage imageNamed:@"icon_star.png"];
                [cell.rateView addSubview:startView];
            }else{
                UIImageView *startView = [[UIImageView alloc] initWithFrame:CGRectMake(i*starWi, 0, starWi, starWi)];
                startView.image = [UIImage imageNamed:@"icon_ustar.png"];
                [cell.rateView addSubview:startView];
            }
        }
        
        
        // kiem tra hinh trong local hay tren mang
        
        
        
        if ([item.image containsString:@"http://"])  {
            [cell.avartaImage sd_setImageWithURL:[NSURL URLWithString:item.image] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                //doi avarta thanh hinh tron
                cell.avartaImage.layer.cornerRadius = cell.avartaImage.frame.size.width/2;
                cell.avartaImage.clipsToBounds = YES;
                
            }];
        }
        else{
            cell.avartaImage.image = [UIImage imageNamed:item.image];
        }
        return cell;
    }
        
       else {
           Food *item = _mangSearch[indexPath.row];
        UITableViewCell *cell = [UITableViewCell new];
        cell.textLabel.text = item.name;
        
        
        
        
        // kiem tra hinh trong local hay tren mang
        
        
        
        if ([item.image containsString:@"http://"])  {
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:item.image] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                //doi avarta thanh hinh tron
                cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width/2;
                cell.imageView.clipsToBounds = YES;
                
            }];
        }
        else{
            cell.imageView.image = [UIImage imageNamed:item.image];
        }
        return cell;
    }
    
    
}
- (IBAction)onAddTap:(id)sender {
    //// Get view addviewcontroller tu Main.Storuboard
    
    AddViewController *view = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"addView"];
    // chay qua
    [self.navigationController pushViewController:view animated:YES];
    // nhay len
    //[self.navigationController presentViewController:view animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.foodTBV reloadData];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[DataManager shareIntance].foodList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [[DataManager shareIntance]saveBack];
    }
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
      _mangSearch = [[NSMutableArray alloc] init];
    
    for (Food *food in[DataManager shareIntance].foodList ) {
        NSString *sname = food.name;
        if ([sname.lowercaseString hasPrefix:searchText.lowercaseString]) {
            [_mangSearch addObject:food];
        }
    }
    [_TBV reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
