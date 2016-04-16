//
//  CameraViewController.m
//  BabySticker
//
//  Created by Ankit on 12/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import "CameraViewController.h"
#import <CoreMedia/CoreMedia.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Foundation/Foundation.h>
#import <ImageIO/ImageIO.h>
#import <CoreVideo/CoreVideo.h>

#define DegreesToRadians(x) ((x) * M_PI / 180.0)

@interface CameraViewController () 

@property(nonatomic, retain) AVCaptureStillImageOutput *stillImageOutput;

@end

@implementation CameraViewController
@synthesize stillImageOutput,imagePreview;
- (void)viewDidLoad {
    [super viewDidLoad];
    captureImage.layer.masksToBounds = YES;
    captureImage.clipsToBounds = YES;
    captureImage.hidden = YES;
    self.imagePreview.backgroundColor = [UIColor blackColor];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self initializeCamera];
    });
    [UIApplication sharedApplication].statusBarHidden = YES;
    btnCapture.enabled = YES;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self offFlashlight];
    [UIApplication sharedApplication].statusBarHidden = NO;
    
}

- (void) initializeCamera
{
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    session.sessionPreset = AVCaptureSessionPresetPhoto;
    
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [captureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        captureVideoPreviewLayer.frame = self.imagePreview.bounds;
    });
    
    [self.imagePreview.layer addSublayer:captureVideoPreviewLayer];
    
    UIView *view = [self imagePreview];
    CALayer *viewLayer = [view layer];
    [viewLayer setMasksToBounds:YES];
    
    CGRect bounds = [view bounds];
    [captureVideoPreviewLayer setFrame:bounds];
    
    NSArray *devices = [AVCaptureDevice devices];
    AVCaptureDevice *frontCamera;
    AVCaptureDevice *backCamera;
    
    for (AVCaptureDevice *device in devices) {
        
        NSLog(@"Device name: %@", [device localizedName]);
        
        if ([device hasMediaType:AVMediaTypeVideo]) {
            
            if ([device position] == AVCaptureDevicePositionBack) {
                NSLog(@"Device position : back");
                backCamera = device;
            }
            else {
                NSLog(@"Device position : front");
                frontCamera = device;
            }
        }
    }
    
    if (!FrontCamera) {
        NSError *error = nil;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:backCamera error:&error];
        if (!input) {
            NSLog(@"ERROR: trying to open camera: %@", error);
        }
        [session addInput:input];
    }
    
    if (FrontCamera) {
        NSError *error = nil;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:frontCamera error:&error];
        if (!input) {
            NSLog(@"ERROR: trying to open camera: %@", error);
        }
        [session addInput:input];
    }
    
    stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [stillImageOutput setOutputSettings:outputSettings];
    
    [session addOutput:stillImageOutput];
    
    [session startRunning];
}

- (IBAction)snapImage:(id)sender {
//    if (!haveImage) {
//        captureImage.image = nil; //remove old image from view
//        captureImage.hidden = NO; //show the captured image view
//        imagePreview.hidden = YES; //hide the live video feed
        btnCapture.enabled = NO;
        [self capImage];
    
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(navigation) userInfo:nil repeats:NO];
//    }
//    else
//    {
//        captureImage.hidden = YES;
//        imagePreview.hidden = NO;
//        haveImage = NO;
//    }
}

-(IBAction)flsahButtonPress:(id)sender {
    
    if ([btnFlashLight.titleLabel.text isEqualToString:@"Auto"]) {
        [btnFlashLight setTitle:@"On" forState:UIControlStateNormal];
    } else if ([btnFlashLight.titleLabel.text isEqualToString:@"On"]) {
        [btnFlashLight setTitle:@"Off" forState:UIControlStateNormal];
        [self onFlashLight];
    } else if ([btnFlashLight.titleLabel.text isEqualToString:@"Off"]) {
        [btnFlashLight setTitle:@"Auto" forState:UIControlStateNormal];
        [self offFlashlight];
    }
    
    
//    @autoreleasepool {
//        NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
//        for (AVCaptureDevice *device in devices)
//        {
//            if ([device hasFlash]) {
//                [device lockForConfiguration:nil];
//                if (bulPicker) {
//                    [device setTorchMode:AVCaptureTorchModeOff];
//                    bulPicker = NO;
//                } else  {
//                    [device setTorchMode:AVCaptureTorchModeOn];
//                    bulPicker = YES;
//                }
//                [device unlockForConfiguration];
//            }
//        }
//    }
}

-(void)offFlashlight {
    
    @autoreleasepool {
        NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
        for (AVCaptureDevice *device in devices)
        {
            if ([device hasFlash]) {
                [device lockForConfiguration:nil];
                [device setTorchMode:AVCaptureTorchModeOff];
                [device unlockForConfiguration];
            }
        }
    }

}

-(void)onFlashLight {
    @autoreleasepool {
        NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
        for (AVCaptureDevice *device in devices)
        {
            if ([device hasFlash]) {
                [device lockForConfiguration:nil];
                [device setTorchMode:AVCaptureTorchModeOn];
                [device unlockForConfiguration];
            }
        }
    }
}

-(void)navigation
{
    captureImage.hidden = YES;
    imagePreview.hidden = NO;
    EditPhotoViewController *editPhotoViewObj = StoryBoard(@"EditPhotoViewController")
    editPhotoViewObj.image = captureImage.image;
    PushViewController(editPhotoViewObj)
}

- (void) capImage { //method to capture image from AVCaptureSession video feed
    
    
    if ([btnFlashLight.titleLabel.text isEqualToString:@"Auto"]) {
        [self onFlashLight];
    }
   
    
    
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in stillImageOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) {
            break;
        }
    }
    
    NSLog(@"about to request a capture from: %@", stillImageOutput);
    [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
        
        if (imageSampleBuffer != NULL) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
            [self offFlashlight];
            [self processImage:[UIImage imageWithData:imageData]];
        }
    }];
}

- (void) processImage:(UIImage *)image { //process captured image, crop, resize and rotate
    haveImage = YES;
    
    if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad) { //Device is ipad
        // Resize image
        UIGraphicsBeginImageContext(CGSizeMake(768, 1022));
        [image drawInRect: CGRectMake(0, 0, 768, 1022)];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        CGRect cropRect = CGRectMake(0, 130, 768, 768);
        CGImageRef imageRef = CGImageCreateWithImageInRect([smallImage CGImage], cropRect);
        //or use the UIImage wherever you like
        
        [captureImage setImage:[UIImage imageWithCGImage:imageRef]];
        
        CGImageRelease(imageRef);
        
    }else{ //Device is iphone
        // Resize image
        UIGraphicsBeginImageContext(CGSizeMake(captureImage.frame.size.height, captureImage.frame.size.height));
        [image drawInRect: CGRectMake(0, 0, captureImage.frame.size.width, captureImage.frame.size.height)];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        CGRect cropRect = CGRectMake(0, 0, captureImage.frame.size.width, captureImage.frame.size.height);
        CGImageRef imageRef = CGImageCreateWithImageInRect([smallImage CGImage], cropRect);
        
        [captureImage setImage:[UIImage imageWithCGImage:imageRef]];
        
        CGImageRelease(imageRef);
    }
    
    captureImage.image = image;
    //adjust image orientation based on device orientation
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) {
        NSLog(@"landscape left image");
        
        [UIView beginAnimations:@"rotate" context:nil];
        [UIView setAnimationDuration:0.5];
        captureImage.transform = CGAffineTransformMakeRotation(DegreesToRadians(-90));
        [UIView commitAnimations];
        
    }
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
        NSLog(@"landscape right");
        
        [UIView beginAnimations:@"rotate" context:nil];
        [UIView setAnimationDuration:0.5];
        captureImage.transform = CGAffineTransformMakeRotation(DegreesToRadians(90));
        [UIView commitAnimations];
        
    }
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown) {
        NSLog(@"upside down");
        [UIView beginAnimations:@"rotate" context:nil];
        [UIView setAnimationDuration:0.5];
        captureImage.transform = CGAffineTransformMakeRotation(DegreesToRadians(180));
        [UIView commitAnimations];
        
    }
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait) {
        NSLog(@"upside upright");
        [UIView beginAnimations:@"rotate" context:nil];
        [UIView setAnimationDuration:0.5];
        captureImage.transform = CGAffineTransformMakeRotation(DegreesToRadians(0));
        [UIView commitAnimations];
    }
}

- (IBAction)switchCamera:(id)sender { //switch cameras front and rear cameras
    if (FrontCamera) {
        FrontCamera = NO;
        [self initializeCamera];
    }
    else {
        FrontCamera = YES;
        [self initializeCamera];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//************************************************************************//
//***********************# IBAction mathod  #*****************************//
//************************************************************************//

#pragma mark - IBAction method


-(IBAction)photoButtonPress:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    EditPhotoViewController *editPhotoViewObj = StoryBoard(@"EditPhotoViewController")
    editPhotoViewObj.image = chosenImage;
    PushViewController(editPhotoViewObj)
    [picker dismissViewControllerAnimated:YES completion:nil];
}




-(IBAction)backButtonPress:(id)sender {
    //[self.navigationController popViewControllerAnimated:YES];
    PopCurrentViewController
}

//************************************************************************//
//***********************# ---------------  #*****************************//
//************************************************************************//

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
