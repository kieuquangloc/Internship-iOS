#import "DetailVC.h"

@interface DetailVC () <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark UITextFieldDelegate

- (bool)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _tfMealName.text = _tfMealName.text;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (selectedImage) {
        _ivPhoto.image = selectedImage;
        UIImage *img = selectedImage;
        _dataImg = UIImageJPEGRepresentation(img, 100);
        
    }
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)selectImageFromLibrary:(UITapGestureRecognizer *)sender {
    [_tfMealName resignFirstResponder];
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:true completion:nil];

}

#pragma mark - My Action

- (IBAction)btnSaveData:(UIBarButtonItem *)sender {
    
    if ([_tfMealName.text length] == 0 || _ivPhoto.image == nil) {
        return;
    }
    
    Meal *newmeal = [[Meal alloc]initWithData:_tfMealName.text Image:UIImageJPEGRepresentation(_ivPhoto.image, 100) Rating:_viRate.rating];
    if (_delegate && [_delegate respondsToSelector:@selector(detailVC:newMeal:)]) {
        
        [_delegate detailVC:self newMeal:newmeal];
        //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        NSLog(@"Delegate = nil\n");
    }

}

@end
