//
//  ItemDetailVC.m
//  FoodTracker
//
//  Created by HHumorous on 9/20/17.
//  Copyright © 2017 HHumorous. All rights reserved.
//

#import "ItemDetailVC.h"
#import "Meal.h"

@interface ItemDetailVC () <UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate> {
    
}

@end

@implementation ItemDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addImage)];
    
    [_imageMeal setUserInteractionEnabled:YES];
    [_imageMeal addGestureRecognizer:tapGesture];
    
//    if let meal = food {
//        navigationItem.title = meal.name
//        foodNameTF.text = meal.name
//        imageFood.image = meal.photo
//        ratingStar.rating = meal.rating
//    }
    
    
    _mealNameTF.delegate = self;
    
    [self updateSaveButtonState];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _saveButton.enabled = false;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self updateSaveButtonState];
    self.navigationItem.title = _mealNameTF.text;
}

#pragma mark UIImagePickerDelegate

- (void)addImage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Notice" message:@"Choose a photo for your meals" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Take a photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"From Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openLibrary];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler: nil]];
    
    [self presentViewController:alert animated:true completion:nil];
}

- (void)takePhoto {
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        _imagePicker.allowsEditing = YES;
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        [self presentViewController:_imagePicker animated:true completion:nil];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Camera not found" message:@"This device has no Camera" preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIPreviewActionStyleDefault handler:nil];
        [alert addAction:ok];
        [self presentViewController:alert animated:true completion:nil];
    }
}

- (void)openLibrary {
    [_mealNameTF resignFirstResponder];
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;

    [self presentViewController:imagePicker animated:true completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (selectedImage) {
        _imageMeal.image = selectedImage;
        
    }
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)setDedaultNameButton:(UIButton *)sender {
    
    _mealNameTF.text = @"Delicious Meal";
}

- (IBAction)cancelButton:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:true];
}

- (void)updateSaveButtonState {
    NSString *text = _mealNameTF.text ? _mealNameTF.text:@"";
    _saveButton.enabled = ![text isEqualToString:@""];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] init];

    if (button == _saveButton) {
        button = sender;
    }
    
    NSString *name = _mealNameTF.text ? _mealNameTF.text:@"";
    UIImage *image = _imageMeal.image;
    NSInteger rating = _ratingStar.rating;
    
    [_food initMealWithName:name Photo:image AndRating:rating];
    
}
@end
