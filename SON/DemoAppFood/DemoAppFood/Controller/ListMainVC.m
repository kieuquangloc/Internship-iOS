//
//  ListMainVC.m
//  DemoAppFood
//
//  Created by ThanhSon on 8/15/16.
//  Copyright © 2016 ThanhSon. All rights reserved.
//

#import "ListMainVC.h"


@interface ListMainVC () <UITableViewDelegate,UITableViewDataSource,RateViewDelegate>{
    BOOL isEdit;
}

@end

@implementation ListMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createButtonEdit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self getData];
}

#pragma mark - UICoredata

- (void)getData {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest  = [[NSFetchRequest alloc] initWithEntityName:@"Meal"];
    NSError *error;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
    if (!error) {
        _listMeal = [[NSMutableArray alloc] initWithArray:result];
        [self.tbvListMeal reloadData];
    }
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listMeal.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellId = @"cellmeal";
    MealCell *cell = (MealCell *)[_tbvListMeal dequeueReusableCellWithIdentifier:CellId forIndexPath:indexPath];
    Meal *theMeal = _listMeal[indexPath.row];
    cell.lblNameMeal.text = theMeal.name;
    cell.imgMeal.image = [UIImage imageWithData:theMeal.image];
    [self CreateStar:cell.viewRatting :[theMeal.rating integerValue]];
    isEdit? (cell.accessoryType = UITableViewCellAccessoryDetailButton) : (cell.accessoryType = UITableViewCellEditingStyleNone);
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AddMealVC *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    Meal *currentMeal = _listMeal[indexPath.row];
    detailView.currentMeal = currentMeal;
    [self.navigationController pushViewController:detailView animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObjectContext *context = [self managedObjectContext];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Meal *currentMeal = _listMeal[indexPath.row];
        [context deleteObject:currentMeal];
        NSError *error;
        [context save:&error];
        if (error) {
            NSLog(@"%@",[error localizedDescription]);
        }
        [_listMeal removeObject:currentMeal];
        [self.tbvListMeal deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - ButtonEdit

- (void)createButtonEdit {
    isEdit =NO;
    [_btnEdit setTarget:self];
    [_btnEdit setAction:@selector(ChooseEditMeal)];
}

- (void)ChooseEditMeal {
    if (isEdit) {
        [_tbvListMeal reloadData];
        _btnEdit.title =@"EDIT";
        isEdit=false;
    } else {
        [_tbvListMeal reloadData];
        isEdit=true;
        _btnEdit.title =@"SAVE";
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    Meal *currentMeal = _listMeal[indexPath.row];
    [self editStudentWithAlert:currentMeal];
}

- (void)editStudentWithAlert:(Meal *)meal{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Info"
                                                                   message:@"Detail Meal"
                                                            preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                            //Delele
                                                         }];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
        UITextField * txtName = alert.textFields.firstObject;
        NSManagedObjectContext * context = [self managedObjectContext];
        meal.name = txtName.text;
        NSError * error;
        [context save:&error];
        if (!error) {
            [_tbvListMeal reloadData];
        }
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *txtName) {
        txtName.text = meal.name;
    }];

    [alert addAction:saveAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)btnAddMeal:(id)sender {
    AddMealVC *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    [self.navigationController pushViewController:detailView animated:YES];

}

#pragma InitRating

- (void)CreateStar:(RateView*)_viewRate :(NSInteger)rate {
    _viewRate.maxRating = 5;
    _viewRate.delegate = self;
    [_viewRate setUserInteractionEnabled:NO];
    [_viewRate.delegate rateView:_viewRate ratingDidChange:rate];
}

- (void)rateView:(RateView *)rateView ratingDidChange:(NSInteger)rating {
    rateView.rating = rating;
}


@end
