//
//  MealVC.m
//  FoodTracker
//
//  Created by NguyenMach-MAC on 8/15/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "MealVC.h"
#import "Meal.h"

@interface MealVC ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    NSURL *path;
    NSData *myData ;

}
@end

@implementation MealVC




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    
    
    return true;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return true;

}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    [picker dismissViewControllerAnimated:true completion:nil];
    
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    UIImage *selectedImage = info[UIImagePickerControllerOriginalImage];
//    myData = UIImagePNGRepresentation(selectedImage);
    _imvFood.image = selectedImage;
    path = [info valueForKey:UIImagePickerControllerReferenceURL];//save url when chose image
    
    //UIImage *cameraImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    

    
    [picker dismissViewControllerAnimated:true completion:nil];
}


- (IBAction)selectImageFromPhotoLibrary:(UITapGestureRecognizer*)sender {
    
    [_tfContent resignFirstResponder];
    
    // UIImagePickerController is a view controller that lets a user pick media from their photo library.
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    
    // Only allow photos to be picked, not taken.
    [imagePickerController sourceType ] ;
    
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    // Make sure ViewController is notified when the user picks an image.
    imagePickerController.delegate = self;
    

    [self presentViewController:imagePickerController animated:true completion:nil];
    
    
    
}

- (IBAction)onClickSent:(UIButton *)sender {
    
    Meal *meal = [[Meal alloc]init];
    
    meal.title = _tfContent.text;
    meal.social_rank = (NSInteger)_ratingControl.rating;
    
    NSData *data = (NSData*)_imvFood.image;
    
    meal.dataImage = UIImageJPEGRepresentation(data, 100);
    
     // NSLog(@"%@",meal.dataImage);
    
  

}




@end
