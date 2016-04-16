//
//  UtilityClass.m
//  BabySticker
//
//  Created by Ankit on 14/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import "UtilityClass.h"
#import "Constant.h"
#import "AppDelegate.h"

@implementation UtilityClass

+(void)setConstain:(UIView *)view setConstain:(CGFloat)constainValue andlayoutConstain:(NSLayoutConstraint *)constrain{
    [view layoutIfNeeded];
    [view setNeedsUpdateConstraints];
    [view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionLayoutSubviews animations:^{
        constrain.constant = constainValue;
        [view layoutIfNeeded];
    } completion:nil];
}


//+(NSString *)createDocumentDirectory:(NSString *)strFolderName {
//    NSError *error;
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",strFolderName]];
//    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
//        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
//    return documentsDirectory;
//}


+(BOOL)createDocumentDirectory:(NSString *)strFolderName
{
    
    NSError *error;
    NSString *documentsDirectory = [self getDocumentDirectoryPath]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",strFolderName]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Will Create folder
        return YES;
    } else {
        return NO;
    }
    
}

+(NSArray *)GetDocumentDirectoryFolderList
{
    
    NSString *documentsDirectory = [self getDocumentDirectoryPath];
    
    NSMutableArray *filePathsArray = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:nil] mutableCopy];
    if ([filePathsArray containsObject:@".DS_Store"]) {
        [filePathsArray removeObject:@".DS_Store"];
    }
    return filePathsArray;
}

+(NSArray *)getAllImageAndVideosFromFolder:(NSString *)strFolderName {
    
    
    NSString *documentsPath = [self getDocumentDirectoryPath];
    
    
    NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/%@",documentsPath,strFolderName] error:nil];
    NSMutableArray *fileList=[[NSMutableArray alloc]init];
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]; // NEW LINE 1
    
    for (NSString *filename in dirContents) {
        NSString *fileExt = [filename pathExtension];
        if ([fileExt isEqualToString:@"png"]) {
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",strFolderName,filename]]; // NEW LINE 2
            [fileList addObject:fullPath]; // NEW LINE 3
        }
    }
    NSLog(@"%@",fileList);
    return fileList;
}

+(NSArray *)getAllVideosFromFolder:(NSString *)strFolderName {
    
    
    NSString *documentsPath = [self getDocumentDirectoryPath];
    
    
    NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/%@",documentsPath,strFolderName] error:nil];
    NSMutableArray *fileList=[[NSMutableArray alloc]init];
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]; // NEW LINE 1
    
    for (NSString *filename in dirContents) {
        NSString *fileExt = [filename pathExtension];
        if ([fileExt isEqualToString:@"mp4"]) {
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",strFolderName,filename]]; // NEW LINE 2
            [fileList addObject:fullPath]; // NEW LINE 3
        }
    }
    NSLog(@"%@",fileList);
    return fileList;
}



+(NSString *)getDocumentDirectoryPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

//************************************************************************//
//*****************# set Color tint Color method  #***********************//
//************************************************************************//

#pragma mark - _________set Color tint Color method____________

+(UIImage *)colorizeImage:(UIImage *)baseImage color:(UIColor *)theColor {
    UIGraphicsBeginImageContext(baseImage.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, baseImage.size.width, baseImage.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, area, baseImage.CGImage);
    [theColor set];
    CGContextFillRect(ctx, area);
    CGContextRestoreGState(ctx);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextDrawImage(ctx, area, baseImage.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


+(UIImage *)convertImageToGrayScale:(UIImage *)image
{
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // Grayscale color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // Create bitmap content with current image size and grayscale colorspace
    CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
    
    // Draw image into current context, with specified rectangle
    // using previously defined context (with grayscale colorspace)
    CGContextDrawImage(context, imageRect, [image CGImage]);
    
    // Create bitmap image info from pixel data in current context
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // Create a new UIImage object
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    
    // Release colorspace, context and bitmap information
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
    
    // Return the new grayscale image
    return newImage;
}

+ (UIImage *)imageBlackAndWhite:(UIImage *)img
{
    CIImage *beginImage = [CIImage imageWithCGImage:img.CGImage];
    
    CIImage *output = [CIFilter filterWithName:@"CIColorMonochrome" keysAndValues:kCIInputImageKey, beginImage, @"inputIntensity", [NSNumber numberWithFloat:1.0], @"inputColor", [[CIColor alloc] initWithColor:[UIColor whiteColor]], nil].outputImage;
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgiimage = [context createCGImage:output fromRect:output.extent];
    UIImage *newImage = [UIImage imageWithCGImage:cgiimage];
    
    CGImageRelease(cgiimage);
    
    return newImage;
}

+(void)setMyCustomAnimationView:(UIView *)view andFrame:(CGRect)rect {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    view .frame = rect;
    [UIView commitAnimations];
}
+(void)setMyCustomScrollAnimationView:(UIScrollView *)view andFrame:(CGPoint)point {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    view .contentOffset = point;
    [UIView commitAnimations];
}

+(void)openUrlLink:(NSString *)url {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}


//************************************************************************//
//***********************# General mathod  #*****************************//
//************************************************************************//

#pragma mark - --------------General method------------

+(NSString *)getCurrentDate {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

+(NSString *)getCurrentTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HHmmss";
    return [dateFormatter stringFromDate:[NSDate date]];
}

+(NSString *)trimFolderName:(NSString *)string{
    return [string stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceCharacterSet]];
}

+(void)showAlert:(NSString *)message
{
    
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Baby Sticker"
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction * action)
                               {
                                   //Handel no, thanks button
                                   
                               }];
    
    [alert addAction:noButton];
    [[UtilityClass topViewController] presentViewController:alert animated:YES completion:nil];
    
}
+ (UIViewController*)topViewController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

//************************************************************************//
//***********************# ---------------  #*****************************//
//************************************************************************//


// Get Run Time Localized String

+(NSString *)runTimeLocalizedStringForKey:(NSString *)key
{
    NSString *path= [[NSBundle mainBundle] pathForResource:AppDel.strSelectedLang ofType:@"lproj"];
    NSBundle *languageBundle = [NSBundle bundleWithPath:path];
    NSString *localizedString=[languageBundle localizedStringForKey:key value:@"" table:nil];
    return localizedString;
}

+(void)SaveUserDefaultValue :(id)object key:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:object forKey:key];
    [defaults synchronize];
}

+(id)getUserDefaultValue:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}




@end
