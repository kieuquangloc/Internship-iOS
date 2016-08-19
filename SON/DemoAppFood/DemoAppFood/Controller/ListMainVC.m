//
//  ListMainVC.m
//  DemoAppFood
//
//  Created by ThanhSon on 8/15/16.
//  Copyright © 2016 ThanhSon. All rights reserved.
//

#import "ListMainVC.h"


@interface ListMainVC () <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating,RateViewDelegate>{
    BOOL isEdit;
    BOOL isSearching;
}

@end

@implementation ListMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createButtonEdit];
    [self initSearchController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self getData];
}

#pragma mark - Coredata

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
    if (isSearching) {
        return _listMealResults.count;
    } else return _listMeal.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellId = @"cellmeal";
    MealCell *cell = (MealCell *)[_tbvListMeal dequeueReusableCellWithIdentifier:CellId forIndexPath:indexPath];
    Meal *theMeal ;
    if(isSearching){
        theMeal = _listMealResults[indexPath.row];
    } else {
        theMeal = _listMeal[indexPath.row];
    }
    cell.lblNameMeal.text = theMeal.name;
    cell.imgMeal.image = [UIImage imageWithData:theMeal.image];
    [self createStar:cell.viewRatting :[theMeal.rating integerValue]];
    isEdit? (cell.accessoryType = UITableViewCellAccessoryDetailButton) : (cell.accessoryType = UITableViewCellEditingStyleNone);
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_searchController setActive:NO];
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
    [_btnEdit setAction:@selector(chooseEditMeal)];
}

- (void)chooseEditMeal {
    if (isEdit) {
        _btnEdit.title =@"EDIT";
        isEdit=false;
        [_tbvListMeal reloadData];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ChooseType"
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *btnSortName = [UIAlertAction actionWithTitle:@"Sort Name"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
            NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO]];
            [_listMeal sortUsingDescriptors:sortDescriptors];
            [_tbvListMeal reloadData];
        }];
        UIAlertAction *btnSortRate = [UIAlertAction actionWithTitle:@"Sort Rate"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
            NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"rating" ascending:NO]];
            [_listMeal sortUsingDescriptors:sortDescriptors];
            [_tbvListMeal reloadData];
        }];
        UIAlertAction *btnEditName = [UIAlertAction actionWithTitle:@"Edit Name"
                                                              style:UIAlertActionStyleCancel
                                                            handler:^(UIAlertAction * _Nonnull action) {
            isEdit=true;
            _btnEdit.title =@"SAVE";
            [_tbvListMeal reloadData];
        }];
        [alert addAction:btnSortName];
        [alert addAction:btnSortRate];
        [alert addAction:btnEditName];
        [self presentViewController:alert animated:YES completion:nil];
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

#pragma mark - InitRating

- (void)createStar:(RateView*)_viewRate :(NSInteger)rate {
    _viewRate.maxRating = 5;
    _viewRate.delegate = self;
    [_viewRate setUserInteractionEnabled:NO];
    [_viewRate.delegate rateView:_viewRate ratingDidChange:rate];
}

- (void)rateView:(RateView *)rateView ratingDidChange:(NSInteger)rating {
    rateView.rating = rating;
}

#pragma mark - UISearchController

- (void)initSearchController {
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.searchBar.placeholder = @"Search Meal";
    _searchController.searchBar.delegate = self;
    [_searchController.searchBar sizeToFit];
    _tbvListMeal.tableHeaderView = _searchController.searchBar;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    _listMealResults = [[NSMutableArray alloc] init];
    NSString *strSearch = searchController.searchBar.text;
    for ( Meal *meal in _listMeal) {
        if([[meal.name lowercaseString] hasPrefix:[strSearch lowercaseString]]){
            [_listMealResults addObject:meal];
        }
    }
    [_tbvListMeal reloadData];
    if(![strSearch isEqualToString:@""]){
        searchController.dimsBackgroundDuringPresentation = NO;
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSearching = true;
    [_tbvListMeal reloadData];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    isSearching = false;
    [_tbvListMeal reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    isSearching = false;
    [_tbvListMeal reloadData];
}

@end
