//
//  ViewController.m
//  FoodTracker
//
//  Created by Hungpv on 8/15/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tfmealName.delegate = self;
    //self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITextFieldDelegate

- (bool)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _lblmealName.text = _tfmealName.text;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (selectedImage) {
        _ivPhoto.image = selectedImage;
    }
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

#pragma mark - Actions
- (IBAction)selectPhotoFromLibrary:(UITapGestureRecognizer *)sender {
    [_tfmealName resignFirstResponder];
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:true completion:nil];
}

//- (IBAction)btnCancelTapped:(UIBarButtonItem *)sender {
//    
//    UINavigationController *view = [self presentingViewController];
//    
//    if (view) {
//        [self dismissViewControllerAnimated:TRUE completion:nil];
//    } else {
//        [self.navigationController popViewControllerAnimated:TRUE];
//    }
//}

@end
