//
//  BaseTableViewController.m
//  a2
//
//  Created by Hungpv on 8/16/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "ListFoodVC.h"
//NSString *const a = @"demo";
@interface ListFoodVC () <UITableViewDataSource,UITableViewDelegate, CellDelegate>{
    NSMutableArray * _arrData;
    NSString * _url;
}


@end

@implementation ListFoodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initUI];
    [self initVar];
    [self getDataFromServer];

}

#pragma mark - init.

- (void)initUI{
   // self.tbvContent.rowHeight = 100;
   // self.tbvContent.estimatedRowHeight = UITableViewAutomaticDimension;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem.action = @selector(enableEdit);
}

- (void)initVar{
    if (!_arrData) {
        _arrData = [[NSMutableArray alloc]init];
    }
}

- (void)enableEdit {
    
    if (_tbvContent.editing) {
        _tbvContent.editing = NO;
        self.navigationItem.leftBarButtonItem.title = @"Edit";
    } else {
        _tbvContent.editing = YES;
        self.navigationItem.leftBarButtonItem.title = @"Done";
    }
}


#pragma mark - GetDataFromServer.

- (void)getDataFromServer{
    
    [SVProgressHUD show];
    _url = @"http://food2fork.com/api/search?key=4d699174e2340160bb34e85865574bb3&q=shredded%20chicken";
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL
                                                          URLWithString:_url]];
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
   
    
    if (response) {
        [SVProgressHUD dismiss];
        NSDictionary *arrData = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
        
        _arrData = [arrData[@"recipes"] mutableCopy];
        [_tbvContent reloadData];
    }else{
        NSLog(@"Error getData Server");
    }
}

- (IBAction)btnEdit:(UIBarButtonItem *)sender {
    _tbvContent.editing = YES;
}

#pragma mark - TableViewDelegate, TableviewDataSource.

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrData.count;
}

// My code

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell.ivPhoto  sd_setImageWithURL:[NSURL URLWithString:_arrData[indexPath.row][@"image_url"]] placeholderImage:[UIImage imageNamed:@"apple"]];
    cell.lblMealname.text = _arrData[indexPath.row][@"title"];
//Check Click button star.
    [cell.viRatinh updateButtonSelectonStates];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_arrData removeObjectAtIndex:indexPath.row];
        [_tbvContent deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [_tbvContent reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100.f;
    }
    return 0.0;
}

- (void)CellDelegate:(Cell *)cell withActionBtn:(UIButton *)btn{
    NSLog(@"TEST");
     
}



@end
