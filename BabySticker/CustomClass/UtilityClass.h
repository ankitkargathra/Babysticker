//
//  UtilityClass.h
//  BabySticker
//
//  Created by Ankit on 14/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constant.h"

@interface UtilityClass : NSObject



// set constrain with Animation
+(void)setConstain:(UIView *)view setConstain:(CGFloat)constain andlayoutConstain:(NSLayoutConstraint *)constrain;


// create Folder in Document Directory
#pragma mark __________________Pratik______________________

+(BOOL)createDocumentDirectory:(NSString *)strFolderName;
+(NSArray *)GetDocumentDirectoryFolderList;
+(NSString *)getDocumentDirectoryPath;
//+(NSString *)createDocumentDirectory:(NSString *)strFolderName;



#pragma mark __________________Ankit_____________________
+ (UIImage *)imageBlackAndWhite:(UIImage *)img;
+(NSString *)getCurrentDate;
+(UIImage *)colorizeImage:(UIImage *)baseImage color:(UIColor *)theColor;
+(UIImage *)convertImageToGrayScale:(UIImage *)image;
+(void)setMyCustomAnimationView:(UIView *)view andFrame:(CGRect)rect;
+(void)setMyCustomScrollAnimationView:(UIScrollView *)view andFrame:(CGPoint)point;
+(NSString *)trimFolderName:(NSString *)str;
+(void)showAlert:(NSString *)message;
+(NSArray *)getAllImageAndVideosFromFolder:(NSString *)strFolderName;
+(NSArray *)getAllVideosFromFolder:(NSString *)strFolderName;
+(void)openUrlLink:(NSString *)url;
+ (UIViewController*)topViewController;
+(NSString *)runTimeLocalizedStringForKey:(NSString *)key;
+(void)SaveUserDefaultValue :(id)object key:(NSString *)key;
+(id)getUserDefaultValue:(NSString *)key;

@end
