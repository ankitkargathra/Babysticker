//
//  BeforeStartViewController.m
//  BabySticker
//
//  Created by Ankit on 12/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import "BeforeStartViewController.h"

@interface BeforeStartViewController ()

@end

@implementation BeforeStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//************************************************************************//
//***********************# IBAction mathod  #*****************************//
//************************************************************************//

#pragma mark - IBAction method


-(IBAction)startButtonPress:(UIButton *)sender {
    
    if(sender.tag == 1) {
        CameraViewController *cameraViewObj = StoryBoard(@"CameraViewController")
        //
        //    CATransition* transition = [CATransition animation];
        //    transition.duration = 0.4f;
        //    transition.type = kCATransitionFade;
        //    transition.subtype = kCATransitionFromTop;
        //    [self.navigationController.view.layer addAnimation:transition
        //                                                forKey:kCATransition];
        
        PushViewController(cameraViewObj)
    } else {
        CartAndIntroViewController *cartViewObj = StoryBoard(@"CartAndIntroViewController")
        PushViewController(cartViewObj)
    }
    
  
    
}


-(IBAction)backButtonPress:(id)sender {
    PopCurrentViewController
}


//************************************************************************//
//***********************# ---------------  #*****************************//
//************************************************************************//


//************************************************************************//
//***********************# IBAction mathod  #*****************************//
//************************************************************************//

#pragma mark - IBAction method


-(IBAction)photoButtonPress:(UIButton *)sender {
    
    if (sender.tag == 1) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    EditPhotoViewController *editPhotoViewObj = StoryBoard(@"EditPhotoViewController")
    editPhotoViewObj.image = chosenImage;
    PushViewController(editPhotoViewObj)
    [picker dismissViewControllerAnimated:YES completion:nil];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
