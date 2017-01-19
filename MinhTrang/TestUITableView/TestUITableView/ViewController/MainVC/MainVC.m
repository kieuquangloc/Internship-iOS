//
//  ViewController.m
//  TestUITableView
//
//  Created by Miracle on 1/18/17.
//  Copyright © 2017 Miracle. All rights reserved.
//

#import "MainVC.h"
#import "Cell.h"

typedef enum : NSUInteger {
    CellRowImage = 0,
    CellRowFirst,
    CellRowLast,
    CellRowEmail,
    CellRowPass,
    CellRowConfirm,
    CellRowKey,
    CellRowServer,
    CellRowBtnRegister,
    CellRowBtnAlredy
} CellRow;

@interface MainVC () <CellDelegate>{
    NSArray *_arrKeys;
}

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _arrContent = @[@"SHARE PLAN",
                        @"First Name",
                        @"Last Name",
                        @"Username or email",
                        @"Password",
                        @"Confirm Password",
                        @"Registration Key",
                        @"Server address",
                        @"",
                        @"I already have an account"];
    
    _arrKeys = @[@"A", @"B", @"C", @"D"];
    
    _tbv.delegate = self;
    _tbv.dataSource = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapDismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Tableview delegate and Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrContent count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellRow type = indexPath.row;
    switch (type) {
        case CellRowImage:
            return 153;
            break;
            
        case CellRowFirst:
        case CellRowLast:
        case CellRowEmail:
        case CellRowPass:
        case CellRowConfirm:
        case CellRowServer:
            return 50;
            break;
            
        case CellRowKey:
            return 85;
            break;
            
        case CellRowBtnRegister:
            return 50;
            break;
            
        case CellRowBtnAlredy:
            return 40;
            break;
            
        default:
            NSLog(@"heightForRowAtIndexPath Vao default");
            return 0;
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Cell *cell = nil;
    
    CellRow row = indexPath.row;
    switch (row) {
        case CellRowImage:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"CellInfoCompany" forIndexPath: indexPath];
            cell.lblNameCompany.text = _arrContent[row];
            break;
        }
            
        case CellRowFirst:
        case CellRowLast:
        case CellRowEmail:
        case CellRowPass:
        case CellRowConfirm:
        case CellRowServer:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"CellTextFieldContent" forIndexPath: indexPath];
            cell.tfContent.text = _arrContent[row];
            break;
        }
            
        case CellRowKey:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"CellTextFieldKey" forIndexPath: indexPath];
            cell.lblRegistKey.text = _arrContent[row];
            cell.tfKey1.text = _arrKeys[0];
            cell.tfKey2.text = _arrKeys[1];
            cell.tfKey3.text = _arrKeys[2];
            cell.tfKey4.text = _arrKeys[3];
            break;
        }
            
        case CellRowBtnRegister:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"CellBtnRegist" forIndexPath: indexPath];
            [cell.btnRegist setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
            break;
        }
            
        case CellRowBtnAlredy:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"CellLblWarning" forIndexPath: indexPath];
            [cell.btnRegist setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
            break;
            break;
        }
            
        default:
            NSLog(@"heightForRowAtIndexPath Vao default");
            return 0;
            break;
    }
    
    cell.delegate = self;
    return cell;
}

#pragma mark - Cell Delegate
- (void)cell:(Cell *)cell didChangeString:(NSString *)string inTextfield:(UITextField *)tf{
    NSIndexPath *indexpath = [_tbv indexPathForCell:cell];
    CellRow row = indexpath.row;
    
    if (row == CellRowKey) {
        if (cell.tfKey1.isFirstResponder && string.length > 4) {
            [cell.tfKey2 becomeFirstResponder];
        }
    }
}

- (void)cell:(Cell *)cell didBeginEditting:(UITextField *)tf{
    
}

- (void)cell:(Cell *)cell didEndEditting:(UITextField *)tf{
    
}

- (void)cell:(Cell *)cell didPressReturn:(UITextField *)tf{
    NSIndexPath *indexpath = [_tbv indexPathForCell:cell];
    CellRow row = indexpath.row;
    
    if (row == CellRowFirst) {
        Cell *cell = [_tbv cellForRowAtIndexPath:[NSIndexPath indexPathForRow:CellRowLast inSection:0]];
        [cell.tfContent becomeFirstResponder];
    }
}

#pragma mark - Tap dissmiss keyboard
- (void)onTapDismissKeyboard{
    [self.view endEditing:YES];
}

@end
