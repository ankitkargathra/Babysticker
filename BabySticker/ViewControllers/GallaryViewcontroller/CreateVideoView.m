//
//  CreateVideoView.m
//  BabySticker
//
//  Created by Pratik kukadiya on 4/9/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import "CreateVideoView.h"

@interface CreateVideoView ()
@property (strong,nonatomic) IBOutlet UICollectionView *collectionViewObj;
@property (strong, nonatomic) NSMutableArray *arrayAllImages;
@property (strong, nonatomic) NSMutableArray *arraySelectedImages;

@end

@implementation CreateVideoView
@synthesize FolderName;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.arraySelectedImages  = [[NSMutableArray alloc]init];
    self.arrayAllImages= [[UtilityClass getAllImageAndVideosFromFolder:FolderName] mutableCopy];
    [self.collectionViewObj reloadData];
    
    self.activitiView = [[DGActivityIndicatorView alloc]initWithType:DGActivityIndicatorAnimationTypeBallScaleRippleMultiple tintColor:[UIColor whiteColor]];
    self.activitiView.frame = CGRectMake(0, 0, 50, 50);
    [self.view addSubview:self.activitiView];
    [self.view bringSubviewToFront:self.activitiView];
    //    [self.activitiView startAnimating];
    self.activitiView.hidden = YES;
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.activitiView.center = self.view.center;
//    [self.view setFrame:[[UIScreen mainScreen] bounds]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrayAllImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    UIImageView *imageView= [cell viewWithTag:100];
    imageView.image = [UIImage imageWithContentsOfFile:[self.arrayAllImages objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.arraySelectedImages containsObject:[self.arrayAllImages objectAtIndex:indexPath.item]]) {
        [self.arraySelectedImages removeObject:[self.arrayAllImages objectAtIndex:indexPath.item]];
        UICollectionViewCell *cell = [self.collectionViewObj cellForItemAtIndexPath:indexPath];
        UIImageView *imageView= [cell viewWithTag:100];
        imageView.layer.borderWidth =0;
        imageView.layer.borderColor = [UIColor clearColor].CGColor;
    }
    else
    {
        [self.arraySelectedImages addObject:[self.arrayAllImages objectAtIndex:indexPath.item]];
        UICollectionViewCell *cell = [self.collectionViewObj cellForItemAtIndexPath:indexPath];
        UIImageView *imageView= [cell viewWithTag:100];
        imageView.layer.borderWidth = 2;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnMakeVideoPress:(id)sender{
    if (self.arraySelectedImages.count > 0)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.activitiView.hidden = NO;
            [self.activitiView startAnimating];
            self.view.userInteractionEnabled = NO;
        });
        
        [self performSelector:@selector(createVideo) withObject:nil afterDelay:1.0];
    }
    else
    {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Baby Steckers" message:@"Select any image" preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [controller dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)createVideo {
    
    
    ///////////// setup OR function def if we move this to a separate function ////////////
    
    NSError *error = nil;
    
    // set up file manager, and file videoOutputPath, remove "test_output.mp4" if it exists...
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *documentsDirectory = NSTemporaryDirectory();
    NSString *videoOutputPath = [documentsDirectory stringByAppendingPathComponent:@"test_output.mp4"];
    
    NSString *documentsPath = [UtilityClass getDocumentDirectoryPath]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/babySticker_%@.mp4",FolderName,[UtilityClass getCurrentDate]]]; //Add the file name
   // NSLog(@"%@",filePath);

    // get rid of existing mp4 if exists...
    if ([fileMgr removeItemAtPath:videoOutputPath error:&error] != YES){
        // NSLog(@"Unable to delete file: %@", [error localizedDescription]);
 
    }
    
    UIImage *ImagforDM = [[UIImage imageWithContentsOfFile:[self.arraySelectedImages objectAtIndex:0]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    CGSize imageSize = ImagforDM.size;
    NSUInteger fps = 30;
    
    NSMutableArray *imageArray;
    imageArray = [[NSMutableArray alloc] initWithCapacity:self.arraySelectedImages.count];
   // NSLog(@"-->imageArray.count= %lu", (unsigned long)imageArray.count);
    for (NSString* path in self.arraySelectedImages)
    {
        UIImage *imgThumb = [[UIImage imageWithContentsOfFile:path] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [imageArray addObject:imgThumb];
        //NSLog(@"-->image path= %@", path);
    }
    
    //////////////     end setup    ///////////////////////////////////
    
    //NSLog(@"Start building video from defined frames.");
    
    AVAssetWriter *videoWriter = [[AVAssetWriter alloc] initWithURL:
                                  [NSURL fileURLWithPath:videoOutputPath] fileType:AVFileTypeQuickTimeMovie
                                                              error:&error];
    NSParameterAssert(videoWriter);
    
    NSDictionary *videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                   AVVideoCodecH264, AVVideoCodecKey,
                                   [NSNumber numberWithInt:imageSize.width], AVVideoWidthKey,
                                   [NSNumber numberWithInt:imageSize.height], AVVideoHeightKey,
                                   nil];
    
    AVAssetWriterInput* videoWriterInput = [AVAssetWriterInput
                                            assetWriterInputWithMediaType:AVMediaTypeVideo
                                            outputSettings:videoSettings];
    
    
    AVAssetWriterInputPixelBufferAdaptor *adaptor = [AVAssetWriterInputPixelBufferAdaptor
                                                     assetWriterInputPixelBufferAdaptorWithAssetWriterInput:videoWriterInput
                                                     sourcePixelBufferAttributes:nil];
    
    NSParameterAssert(videoWriterInput);
    NSParameterAssert([videoWriter canAddInput:videoWriterInput]);
    videoWriterInput.expectsMediaDataInRealTime = YES;
    [videoWriter addInput:videoWriterInput];
    
    //Start a session:
    [videoWriter startWriting];
    [videoWriter startSessionAtSourceTime:kCMTimeZero];
    
    CVPixelBufferRef buffer = NULL;
    
    //convert uiimage to CGImage.
    int frameCount = 0;
    double numberOfSecondsPerFrame = 6;
    double frameDuration = fps * numberOfSecondsPerFrame;
    
    //NSLog(@"**************************************************");
    for(UIImage * img in imageArray)
    {
        //UIImage * img = frm._imageFrame;
        buffer = [self pixelBufferFromCGImage:[img CGImage] andSize:img.size];
        
        BOOL append_ok = NO;
        int j = 0;
        while (!append_ok && j < 30) {
            if (adaptor.assetWriterInput.readyForMoreMediaData)  {
                //print out status:
               // NSLog(@"Processing video frame (%d,%lu)",frameCount,(unsigned long)[imageArray count]);
                
                CMTime frameTime = CMTimeMake(frameCount*frameDuration,(int32_t) fps);
                append_ok = [adaptor appendPixelBuffer:buffer withPresentationTime:frameTime];
                if(!append_ok){
                    NSError *error = videoWriter.error;
                    if(error!=nil) {
                        NSLog(@"Unresolved error %@,%@.", error, [error userInfo]);
                    }
                }
            }
            else {
                //printf("adaptor not ready %d, %d\n", frameCount, j);
                [NSThread sleepForTimeInterval:0.1];
            }
            j++;
        }
        if (!append_ok) {
            //printf("error appending image %d times %d\n, with error.", frameCount, j);
        }
        frameCount++;
    }
    NSLog(@"**************************************************");
    
    //Finish the session:
    [videoWriterInput markAsFinished];
    [videoWriter finishWriting];
    //NSLog(@"Write Ended");
    
    
    
    ////////////////////////////////////////////////////////////////////////////
    //////////////  OK now add an audio file to move file  /////////////////////
    AVMutableComposition* mixComposition = [AVMutableComposition composition];
    
    NSString *bundleDirectory = [[NSBundle mainBundle] bundlePath];
    // audio input file...
    NSString *audio_inputFilePath = [bundleDirectory stringByAppendingPathComponent:@"music.mp3"];
    NSURL    *audio_inputFileUrl = [NSURL fileURLWithPath:audio_inputFilePath];
    
    // this is the video file that was just written above, full path to file is in --> videoOutputPath
    NSURL    *video_inputFileUrl = [NSURL fileURLWithPath:videoOutputPath];
    
    // create the final video output file as MOV file - may need to be MP4, but this works so far...
    NSString *outputFilePath = filePath;
    
    NSURL    *outputFileUrl = [NSURL fileURLWithPath:outputFilePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:outputFilePath])
        [[NSFileManager defaultManager] removeItemAtPath:outputFilePath error:nil];
    
    CMTime nextClipStartTime = kCMTimeZero;
    
    AVURLAsset* videoAsset = [[AVURLAsset alloc]initWithURL:video_inputFileUrl options:nil];

    CMTimeRange video_timeRange = CMTimeRangeMake(kCMTimeZero,videoAsset.duration);
    AVMutableCompositionTrack *a_compositionVideoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    [a_compositionVideoTrack insertTimeRange:video_timeRange ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:nextClipStartTime error:nil];
    
    //nextClipStartTime = CMTimeAdd(nextClipStartTime, a_timeRange.duration);
    
    AVURLAsset* audioAsset = [[AVURLAsset alloc]initWithURL:audio_inputFileUrl options:nil];
    CMTimeRange audio_timeRange = CMTimeRangeMake(kCMTimeZero, audioAsset.duration);
    AVMutableCompositionTrack *b_compositionAudioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    [b_compositionAudioTrack insertTimeRange:audio_timeRange ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:nextClipStartTime error:nil];
    
    
    
    AVAssetExportSession* _assetExport = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetHighestQuality];
    //_assetExport.outputFileType = @"com.apple.quicktime-movie";
    _assetExport.outputFileType = @"public.mpeg-4";
    //NSLog(@"support file types= %@", [_assetExport supportedFileTypes]);
    _assetExport.outputURL = outputFileUrl;
    
    [_assetExport exportAsynchronouslyWithCompletionHandler:
     ^(void ) {
         //[self saveVideoToAlbum:outputFilePath];
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.activitiView stopAnimating];
             [self.activitiView setHidden:NO];
             self.view.userInteractionEnabled = YES;
             [self btnCancelPress:nil];
             [self.delegate reloadTableView];
         });
         
     }
     ];
    
    ///// THAT IS IT DONE... the final video file will be written here...
    NSLog(@"DONE.....outputFilePath--->%@", outputFilePath);
    
    // the final video file will be located somewhere like here:
    // /Users/caferrara/Library/Application Support/iPhone Simulator/6.0/Applications/D4B12FEE-E09C-4B12-B772-7F1BD6011BE1/Documents/outputFile.mov
    
    
    ////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    
}


////////////////////////
- (CVPixelBufferRef) pixelBufferFromCGImage: (CGImageRef)image andSize:(CGSize)aSize{
    
    CGSize size = aSize;
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGImageCompatibilityKey,
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGBitmapContextCompatibilityKey,
                             nil];
    CVPixelBufferRef pxbuffer = NULL;
    
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,
                                          size.width,
                                          size.height,
                                          kCVPixelFormatType_32ARGB,
                                          (__bridge CFDictionaryRef) options,
                                          &pxbuffer);
    if (status != kCVReturnSuccess){
        NSLog(@"Failed to create pixel buffer");
    }
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pxdata, size.width,
                                                 size.height, 8, 4*size.width, rgbColorSpace,
                                                 kCGImageAlphaPremultipliedFirst);
    //kCGImageAlphaNoneSkipFirst);
    CGContextConcatCTM(context, CGAffineTransformMakeRotation(0));
    CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(image),
                                           CGImageGetHeight(image)), image);
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    return pxbuffer;
}



-(IBAction)btnCancelPress:(id)sender{
    [self.view removeFromSuperview];
    
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
