//
//  AddMealVC.m
//  DemoAppFood
//
//  Created by ThanhSon on 8/15/16.
//  Copyright © 2016 ThanhSon. All rights reserved.
//

#import "AddMealVC.h"

@interface AddMealVC () <UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RateViewDelegate>
@end

@implementation AddMealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initTitle];
    [self createTapChooseImage];
    [self createTapdismissKeyboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Init 

- (void)initTitle {
    if (_currentMeal) {
        self.title = @"Edit Meal";
        _txtNameMeal.text = _currentMeal.name;
        [self createStar];
        _imvPhotoImage.image = [UIImage imageWithData:_currentMeal.image];
    } else {
        self.title = @"Add Meal";
        _txtNameMeal.placeholder = @"Name Meal";
        [self createStar];
        _imvPhotoImage.image = [UIImage imageNamed:@"defaultPhoto"];
    }
    _txtNameMeal.delegate = self;
    [_btnSave setTarget:self];
    [_btnSave setAction:@selector(chooseSaveMeal:)];
}

- (void)createStar {
    _viewRate.maxRating = 5;
    _viewRate.delegate = self;
    if(_currentMeal){
        [_viewRate.delegate rateView:_viewRate ratingDidChange:[_currentMeal.rating integerValue]];
    } else {
            [_viewRate.delegate rateView:_viewRate ratingDidChange:0];
    }
}

- (void)rateView:(RateView *)rateView ratingDidChange:(NSInteger)rating {
    _viewRate.rating = rating;

}


#pragma mark -Delegate UITextField

- (void)createTapdismissKeyboard {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}


#pragma mark -ActionButton

- (IBAction)btnSetDefaultName:(id)sender {
    _txtNameMeal.text = @"ImageDefault";
}

- (IBAction)chooseSaveMeal:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    if([_txtNameMeal.text isEqualToString:@""]){
       UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warring"
                                                                      message:nil
                                                               preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleDefault
                                                handler:nil]];
        [self presentViewController:alert animated:true completion:nil];
    } else {
        if (_currentMeal) {
            [self updateCoreData:context withMeal:_currentMeal];
        } else {
            Meal *newMeal = [NSEntityDescription insertNewObjectForEntityForName:@"Meal" inManagedObjectContext:context];
            [self updateCoreData:context withMeal:newMeal];
        }
    }
}

- (void)createTapChooseImage {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(selectImageFromPhotoLibrary)];
    _imvPhotoImage.userInteractionEnabled = true;
    [_imvPhotoImage addGestureRecognizer:tap];
}

#pragma mark - UIImagePickerController


- (void)selectImageFromPhotoLibrary {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Choose type"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *cameraAction){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self showImagePickerController:UIImagePickerControllerSourceTypeCamera];
        }
    }];
    UIAlertAction *libraryAction = [UIAlertAction actionWithTitle:@"Photos Library"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *libraryAction){
        [self showImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    UIAlertAction *savePhotosAction = [UIAlertAction actionWithTitle:@"Saved Photos Album"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *savePhotosAction){
        [self showImagePickerController:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:cameraAction];
    [alert addAction:libraryAction];
    [alert addAction:savePhotosAction];
    
    [self presentViewController:alert animated:true completion:nil];
}


- (void)showImagePickerController:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = sourceType;
    imagePicker.allowsEditing = true;
    [self presentViewController:imagePicker animated:true completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"Did Cancel");
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    _imvPhotoImage.image = image;
    [self dismissViewControllerAnimated:true completion:nil];
}


#pragma mark - Coredata

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)updateCoreData:(NSManagedObjectContext *)managedObjectContext withMeal:(Meal *)currentMeal {
    currentMeal.name = _txtNameMeal.text;
    currentMeal.rating = [NSString stringWithFormat:@"%ld",_viewRate.rating];
    NSData *imageData = UIImagePNGRepresentation(_imvPhotoImage.image);
    currentMeal.image = imageData;
 
    NSError *error;
    [managedObjectContext save:&error];
    if (!error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Info"
                                                                       message:@"Save successfully"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *OkAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *cameraAction) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:OkAction];
        [self presentViewController:alert animated:true completion:nil];
    } else {
        NSLog(@"%@",[error localizedDescription]);
    }
}

@end
