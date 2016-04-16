//
//  PhotosAndVideoViewController.m
//  BabySticker
//
//  Created by Ankit on 20/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import "PhotosAndVideoViewController.h"
#import "ImageGallaryCell.h"
#import "CreateVideoView.h"
#import <MediaPlayer/MediaPlayer.h>

@interface PhotosAndVideoViewController () <ReloadVideoDelegate>
{
    IBOutlet UILabel *lblImages;
    IBOutlet UILabel *lblVideos;
}

@end


@implementation PhotosAndVideoViewController

@synthesize strFolderName;

- (void)viewDidLoad {
    [super viewDidLoad];
    //Set folder name
  //  lblTitle.text = strFolderName;
    
    lblTitle.text=NSLocalizedString(@"Login",nil);
    
    // Do any additional setup after loading the view.
//    [collectionViewObj registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"imgCell"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        arrImage = [UtilityClass getAllImageAndVideosFromFolder:strFolderName];
        [collectionViewObj reloadData];
        [self reloadTableView];
    });    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    lblImages.text = [UtilityClass runTimeLocalizedStringForKey:@"Keyimages"];
    lblVideos.text = [UtilityClass runTimeLocalizedStringForKey:@"Keyvideo"];
}

//************************************************************************//
//********************# Collection view mathod  #*************************//
//************************************************************************//

#pragma mark - --------------Collecton method------------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionViewObj == collectionView)
    {
        return arrImage.count;
    }
    else{
        return ArrayVideo.count;
    }
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageGallaryCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ImageGallaryCell" forIndexPath:indexPath];
    
    UIImageView *imgView = (UIImageView *)[cell viewWithTag:1];
    
//    NSLog(@"%@",[arrImage objectAtIndex:indexPath.row]);
    if (collectionView == collectionViewObj)
    {
        imgView.image = [UIImage imageWithContentsOfFile:[arrImage objectAtIndex:indexPath.row]];
    }
    else{
        imgView.image = [self generateThumbImage:[ArrayVideo objectAtIndex:indexPath.row]];
    }
    
//
//    lbl.text = [[arrImage objectAtIndex:indexPath.row] capitalizedString];
    //    [cell setBackgroundColor:[UIColor redColor]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}

-(void)playVideo:(NSString*)fullpath
{
    NSURL *vedioURL =[NSURL fileURLWithPath:fullpath];
    NSLog(@"vurl %@",vedioURL);
    MPMoviePlayerViewController *videoPlayerView = [[MPMoviePlayerViewController alloc] initWithContentURL:vedioURL];
    [self presentMoviePlayerViewControllerAnimated:videoPlayerView];
    [videoPlayerView.moviePlayer play];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionViewObj1 == collectionView)
    {
        [self playVideo:[ArrayVideo objectAtIndex:indexPath.row]];
    }
}

//************************************************************************//
//***********************# ---------------  #*****************************//
//************************************************************************//

//************************************************************************//
//***********************# IBAction mathod  #*****************************//
//************************************************************************//

#pragma mark - --------------IBAction method------------

-(IBAction)backButtonPress:(id)sender {
    //[self.navigationController popViewControllerAnimated:YES];
    PopCurrentViewController
}

#pragma mark - Video button method -

-(IBAction)btnVideoPress:(id)sender
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Options" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"Collage Photos" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"Create Video" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CreateVideoView *videoViewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateVideoView"];
        videoViewObj.delegate = self;
        
        videoViewObj.FolderName = strFolderName;
        videoViewObj.view.frame = self.view.bounds;
        [self.view addSubview:videoViewObj.view];
        [self addChildViewController:videoViewObj];
        [videoViewObj didMoveToParentViewController:self];
        
        
        UIBezierPath *circleMaskPathInitial = [UIBezierPath bezierPathWithOvalInRect:self.btnVideo.frame];
        CGPoint extremePoint = CGPointMake(self.btnVideo.center.x - 0,  self.btnVideo.center.y - CGRectGetHeight(videoViewObj.view.bounds));
        
        double radius = sqrt((extremePoint.x*extremePoint.x) + (extremePoint.y*extremePoint.y));
        UIBezierPath *circleMaskPathFinal = [UIBezierPath bezierPathWithOvalInRect: CGRectInset(self.btnVideo.frame, -radius, -radius)];
        
        //5
        CAShapeLayer *maskLayer = [CAShapeLayer new];
        maskLayer.path = circleMaskPathFinal.CGPath;
        videoViewObj.view.layer.mask = maskLayer;
        
        //6
        CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        maskLayerAnimation.fromValue = (__bridge id _Nullable)(circleMaskPathInitial.CGPath);
        maskLayerAnimation.toValue = (__bridge id _Nullable)(circleMaskPathFinal.CGPath);
        maskLayerAnimation.duration = .50;
        maskLayerAnimation.delegate = self;
        
        [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:controller animated:YES completion:nil];
}

-(UIImage *)generateThumbImage : (NSString *)filepath
{
    NSURL *url = [NSURL fileURLWithPath:filepath];
    
    AVAsset *asset = [AVAsset assetWithURL:url];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    CMTime time = [asset duration];
    time.value = 0;
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);  // CGImageRef won't be released by ARC
    
    return thumbnail;
}

//************************************************************************//
//***********************# ---------------  #*****************************//
//************************************************************************//


//************************************************************************//
//***********************# Delagate mathod  #*****************************//
//************************************************************************//

#pragma mark - --------------Reload Table method------------



-(void)reloadTableView {
    ArrayVideo = [UtilityClass getAllVideosFromFolder:strFolderName];
    [collectionViewObj1 reloadData];
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
