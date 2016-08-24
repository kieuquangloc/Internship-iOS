//
//  AddVC.m
//  projectA
//
//  Created by Kai Hackintosh on 8/16/16.
//  Copyright © 2016 Kai Hackintosh. All rights reserved.
//

#import "AddVC.h"
#import "DataManager.h"
#import "Meal.h"

@interface AddVC ()
<UIActionSheetDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblcomment;

@end

@implementation AddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tfName.delegate = self;

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _imvMeal.image = [UIImage imageNamed:_strImageName];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) didTapCancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction) didTapDone:(id)sender
{
    
    Meal *meal = [[Meal alloc] init];
    meal.name = _tfName.text;
    UIImage *image = _imvMeal.image;
    NSData *data = UIImageJPEGRepresentation(image, 100);
    meal.dataImg = data;
    meal.rate = _rating;
    
    
    if ([_tfName.text isEqualToString:@"" ] || _imvMeal.image == nil || _rating == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Lưu ý" message:@"Bạn cần điền đầy đủ thông tin" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [self.view addSubview:alert];
        [alert show];
    }else
    {
        
        [[DataManager shareIntance].foodList addObject:meal];
        [[DataManager shareIntance] saveBack];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}

#pragma mark - Action Choose Image

- (IBAction) chooseImage:(UITapGestureRecognizer *)sender{
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"Chọn ảnh" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Thư viện ảnh",@"Camera", nil];
    
    [self.view addSubview:action];
    [action showInView:self.view];
    [self textFieldShouldReturn:_tfName];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *pickerView = [[UIImagePickerController alloc]init];
            pickerView.allowsEditing = YES;
            pickerView.delegate = self;
            pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:pickerView animated:YES completion:nil];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thong Bao" message:@"Bạn đang chạy máy ảo" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
            [self.view addSubview:alert];
            [alert show];
        }
    }
    else if( buttonIndex == 0 )
    {
        
        UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
        pickerView.allowsEditing = YES;
        pickerView.delegate = self;
        [pickerView setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:pickerView animated:YES completion:nil];
        
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
    
    _imvMeal.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Comment START

- (IBAction)commentStarNumber:(id)sender{
    
    NSInteger tag = [sender tag];
    
    NSArray *arrButtons = @[
                            _btnStar1,
                            _btnStar2,
                            _btnStar3,
                            _btnStar4,
                            _btnStar5
                            ];
    NSArray *arrString = @[
                     @"Quá tệ ! ",
                     @"Không ổn ",
                     @"Tàm tạm",
                     @"Hay đó ",
                     @"Tuyệt vời "
                     ];
    
    UIImage *img1 =  [UIImage imageNamed:@"mark-as-favorite-star"];
    UIImage *img2 = [UIImage imageNamed:@"mark-as-favorite-star-2"];
    
    NSArray *arrStars1 = [@[
                            img2,
                            img2,
                            img2,
                            img2,
                            img2
                        ] subarrayWithRange:NSMakeRange(0, tag)];
    
    NSArray *arrStars2 = [@[
                           img1,
                           img1,
                           img1,
                           img1,
                           img1
                           ] subarrayWithRange:NSMakeRange(tag, 5-tag)];
    
    NSArray *arrStars = [arrStars1 arrayByAddingObjectsFromArray:arrStars2];
    
    _rating = tag;
    _lblcomment.text = arrString[tag - 1];
    
    for (UIButton *btn in arrButtons) {
        [btn setImage:arrStars[btn.tag-1] forState:UIControlStateNormal];
    }
}

#pragma mark - DELEGATE TF

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}


@end
