//
//  CameraViewController.h
//  BabySticker
//
//  Created by Ankit on 12/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditPhotoViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface CameraViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    BOOL haveImage;
    BOOL FrontCamera;
   IBOutlet UIImageView *captureImage;
    BOOL bulPicker;
    IBOutlet UIButton *btnCapture;
    IBOutlet UIButton *btnFlashLight;
}
@property (strong, nonatomic)IBOutlet UIView *imagePreview;
@end
