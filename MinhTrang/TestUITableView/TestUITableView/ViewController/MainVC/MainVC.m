//
//  ViewController.m
//  TestUITableView
//
//  Created by Miracle on 1/18/17.
//  Copyright © 2017 Miracle. All rights reserved.
//

#import "MainVC.h"
#import "Cell.h"

@interface MainVC ()

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.arrContent = [NSArray arrayWithObjects: @"SHARE PLAN", @"First Name", @"Last Name", @"Username or email", @"Password", @"Confirm Password",@"Registration Key",  @"Server address", @"", @"I already have an account", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    //[textField becomeFirstResponder];
    
 
    return YES;
}

/*
-(void)gotoPrevTextfield

{
    for(int i=1 ;i<[self.arrContent count];i++)
    {
        if([self.arrContent [i] isFirstResponder])
        {
            [self.arrContent[i-1] becomeFirstResponder];
            [self.arrContent [i] resignFirstResponder];
            
            break;
        }
    }}

-(void)gotoNextTextfield
{
    for( int i=0 ;i<[self.arrContent count];i++)
    {
        if([self.arrContent [i] isFirstResponder])
        {
            [self.arrContent [i+1] becomeFirstResponder];
            [self.arrContent [i] resignFirstResponder];
            
            break;
        }
    }}
*/



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if( indexPath.row == 0) {
        return 153.0;
    } else if ( indexPath.row == 6) {
        return 85.0;
    } else if ( indexPath.row == 8) {
        return 43.0;
    } else if ( indexPath.row == 9) {
        return 57.0;
    }
    return ((tableView.frame.size.height - 153 - 85 - 43 - 57) /6 );
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrContent count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"";
    
    if( indexPath.row == 0) {
        identifier = @"CellInfoCompany";
    } else if ( ((0 < indexPath.row) && (indexPath.row < 6)) || indexPath.row == 7 ) {
        identifier = @"CellTextFieldContent";
    } else if ( indexPath.row == 6) {
        identifier = @"CellTextFieldKey";
    } else if ( indexPath.row == 8) {
        identifier = @"CellBtnRegist";
    } else {
        identifier = @"CellLblWarning";
    }
    
    Cell *cell = [tableView dequeueReusableCellWithIdentifier: identifier forIndexPath: indexPath];
    
    cell.lblNameCompany.text = self.arrContent[indexPath.row];
    
    cell.tfContent.placeholder = self.arrContent[indexPath.row];
    cell.tfContent.layer.cornerRadius = 5;
    
    cell.lblRegistKey.text = self.arrContent[indexPath.row];
    
    cell.lblWarning.text = self.arrContent[indexPath.row];
    
    return cell;
    
}

@end
