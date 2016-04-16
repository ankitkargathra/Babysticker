//
//  EditPhotoViewController.m
//  BabySticker
//
//  Created by Ankit on 13/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import "EditPhotoViewController.h"
#import "FolderCell.h"

typedef enum {    
    kButtonSticker,
    kButtonFilter,
    kButtonReset,
    kButtonDene
}Index;

@interface EditPhotoViewController ()<StickerImageDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet UILabel *lblStickerForBabyMsg;
}
@property (strong, nonatomic) IBOutlet UIView *PopupView;


@end

@implementation EditPhotoViewController

@synthesize foderName,arrFloderName;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.PopupView.hidden = YES;
    imgEditView.clipsToBounds = YES;
    imgEditView.image = self.image;
    self.view.clipsToBounds = YES;
    arrSticker = [NSMutableArray alloc];
    //set filterView
    setFilterViewHide = YES;
    // Do any additional setup after loading the view.
    
    arrSticker = [[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view.
    
    //get All list of folder
    [self GetFolder];

    setFilterViewHide = YES;
    [UtilityClass setConstain:viewFilter setConstain:-viewFilter.frame.size.width andlayoutConstain:filterTralingConstail];
    dispatch_async(dispatch_get_main_queue(), ^{
        blackAndWhiteImage = [UtilityClass imageBlackAndWhite:self.image];
    });
    
}
-(void)viewWillAppear:(BOOL)animated
{
    lblStickerForBabyMsg.text = [UtilityClass runTimeLocalizedStringForKey:@"Keystickerbaby"];
}


//************************************************************************//
//********************# CollectionView mathod  #**************************//
//************************************************************************//

#pragma mark - CollectionView datasource and delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrFloderName.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FolderCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"folderCell" forIndexPath:indexPath];
    
    UILabel *lbl = (UILabel *)[cell viewWithTag:1];
    
    lbl.text = [[arrFloderName objectAtIndex:indexPath.row] capitalizedString];
    //    [cell setBackgroundColor:[UIColor redColor]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 80);
}

#pragma mark - UICollectionView Delegate Method -
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self saveImageToDocumnet:[arrFloderName objectAtIndex:indexPath.item]];
    [self btnCancelPress:nil];
}

-(void)GetFolder
{
    arrFloderName=[[UtilityClass GetDocumentDirectoryFolderList] mutableCopy];
    
    //dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionViewObj reloadData];
        
//    });
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//************************************************************************//
//***********************# IBAction mathod  #*****************************//
//************************************************************************//

#pragma mark - IBAction method

-(IBAction)backButtonPress:(id)sender {
    //[self.navigationController popViewControllerAnimated:YES];
    PopCurrentViewController
}

-(IBAction)tabMenuButtonPress:(UIButton *)sender {
    if (sender.tag == kButtonSticker) {
        
        SelectStickerViewController *selectStickerViewObj = StoryBoard(@"SelectStickerViewController")
        selectStickerViewObj.delegate = self;
        PushViewController(selectStickerViewObj)
                
    } else if (sender.tag == kButtonFilter){
        
        
        if (setFilterViewHide) {
            setFilterViewHide = NO;
            [UtilityClass setConstain:viewFilter setConstain:0 andlayoutConstain:filterTralingConstail];
        } else {
            setFilterViewHide = YES;
            [UtilityClass setConstain:viewFilter setConstain:-viewFilter.frame.size.width andlayoutConstain:filterTralingConstail];
        }
//       imgEditView.image = [UtilityClass convertImageToGrayScale:self.image];
        
    } else if (sender.tag == kButtonReset) {
        
        
        
        for (UIImageView *img in imgEditView.subviews) {
            
            [img removeFromSuperview];
            
        }
        
        imgEditView.image = self.image;
    } else if (sender.tag == kButtonDene) {
        
        self.PopupView.hidden = NO;
        [self.view bringSubviewToFront:self.PopupView];
        self.PopupView.transform = CGAffineTransformMakeScale(0, 0);
        [UIView animateWithDuration:.10 animations:^{
            self.PopupView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.10 animations:^{
                self.PopupView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
            }];
        }];
        
        
        
    } else {
        PopCurrentViewController
    }
}


#pragma mark - IBAction method

-(IBAction)saveBtnPress:(id)sender {
    self.PopupView.hidden = NO;
    [self.view bringSubviewToFront:self.PopupView];
    self.PopupView.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:.10 animations:^{
        self.PopupView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.10 animations:^{
            self.PopupView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
        }];
    }];
    
    
}


-(IBAction)btnCancelPress:(id)sender
{
    [UIView animateWithDuration:1.0 animations:^{
        self.PopupView.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        self.PopupView.transform = CGAffineTransformIdentity;
        self.PopupView.hidden = YES;
        [self.view sendSubviewToBack:self.PopupView];
    }];
}


-(IBAction)btnAddNewFolderPress:(id)sender
{
    
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Add new Folder" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *txtFolderName = [controller.textFields objectAtIndex:0];
        
        if(![[UtilityClass trimFolderName:txtFolderName.text] isEqualToString:@""]){
            BOOL IsFolderCreate=[UtilityClass createDocumentDirectory:[txtFolderName text]];
            if (!IsFolderCreate)
            {
                [UtilityClass showAlert:@"Folder name is Already exist"];
            } else {
                
//                dispatch_async(dispatch_get_main_queue(), ^{
                [self GetFolder];
//                });
                
                
            }
        } else {
            [UtilityClass showAlert:@"Please enter folder name"];
        }
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }]];
    [controller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Folder Name";
    }];
    [self presentViewController:controller animated:YES completion:nil];
    
    
}

-(void)saveImageToDocumnet:(NSString*)FolderName{
    NSData *pngData = UIImagePNGRepresentation([self imageWithView:imgEditView]);
    
    NSString *documentsPath = [UtilityClass getDocumentDirectoryPath]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/babySticker%@.png",FolderName,[UtilityClass getCurrentDate]]]; //Add the file name
    NSLog(@"%@",filePath);
    [pngData writeToFile:filePath atomically:YES]; //Write the file
}

-(UIImage *)imageWithView:(UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *data = UIImageJPEGRepresentation([self imageWithImage:img scaledToSize:CGSizeMake(640, 928)], 0.9);
    UIImage *compressImg = [UIImage imageWithData:data];
    
    return compressImg;
}

- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(IBAction)cancelAndAddfolderButtonPress:(UIButton *)sender {
    
    if (sender.tag == 1) {
        
    } else if (sender.tag == 2) {
        
    }
    
}

-(void)getImageSticker:(UIImage *)image {
    
    UIImage *img = [self changeWhiteColorTransparent:image];
    
    UIImageView *imageSticker = [[UIImageView alloc]initWithImage:img];
    imageSticker.frame = CGRectMake(0, 0, 120, 120);
    imageSticker.center = imgEditView.center;
    imageSticker.userInteractionEnabled = YES;
    
//     create and configure the pinch gesture
        UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureDetected:)];
        [pinchGestureRecognizer setDelegate:self];
        [imageSticker addGestureRecognizer:pinchGestureRecognizer];
    
        // create and configure the rotation gesture
        UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGestureDetected:)];
        [rotationGestureRecognizer setDelegate:self];
        [imageSticker addGestureRecognizer:rotationGestureRecognizer];
    
//     creat and configure the pan gesture
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureDetected:)];
    [panGestureRecognizer setDelegate:self];
    [imageSticker addGestureRecognizer:panGestureRecognizer];

    [imgEditView addSubview:imageSticker];
    [arrSticker addObject:imageSticker];
}




-(UIImage *)changeWhiteColorTransparent: (UIImage *)image
{
    @autoreleasepool {
        
    }
    //convert to uncompressed jpg to remove any alpha channels
    //this is a necessary first step when processing images that already have transparency
    image = [UIImage imageWithData:UIImageJPEGRepresentation(image, 1.0)];
    CGImageRef rawImageRef=image.CGImage;
    //RGB color range to mask (make transparent)  R-Low, R-High, G-Low, G-High, B-Low, B-High
    const CGFloat colorMasking[6] = {222, 255, 222, 255, 222, 255};
    
    UIGraphicsBeginImageContext(image.size);
    CGImageRef maskedImageRef=CGImageCreateWithMaskingColors(rawImageRef, colorMasking);
    
    //iPhone translation
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0.0, image.size.height);
    CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1.0, -1.0);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, image.size.width, image.size.height), maskedImageRef);
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRelease(maskedImageRef);
    UIGraphicsEndImageContext();
    return result;
}

- (void)pinchGestureDetected:(UIPinchGestureRecognizer *)recognizer
{
    UIGestureRecognizerState state = [recognizer state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGFloat scale = [recognizer scale];
        [recognizer.view setTransform:CGAffineTransformScale(recognizer.view.transform, scale, scale)];
        [recognizer setScale:1.0];
    }
}

- (void)rotationGestureDetected:(UIRotationGestureRecognizer *)recognizer
{
    UIGestureRecognizerState state = [recognizer state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGFloat rotation = [recognizer rotation];
        [recognizer.view setTransform:CGAffineTransformRotate(recognizer.view.transform, rotation)];
        [recognizer setRotation:0];
    }
}

- (void)panGestureDetected:(UIPanGestureRecognizer *)recognizer
{
    UIGestureRecognizerState state = [recognizer state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [recognizer translationInView:recognizer.view];
        [recognizer.view setTransform:CGAffineTransformTranslate(recognizer.view.transform, translation.x, translation.y)];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(IBAction)buttonImageFilterPress:(id)sender{
    
    UIButton *btn = (UIButton *)sender
    ;
    
    if (btn.tag == 1) {
        imgEditView.image = self.image;
    } else if (btn.tag == 2) {
        imgEditView.image = blackAndWhiteImage;
    } else if (btn.tag == 3) {
        
    } else if (btn.tag == 4) {
        
    }
    
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
