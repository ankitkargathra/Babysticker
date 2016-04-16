//
//  CreateVideoView.h
//  BabySticker
//
//  Created by Pratik kukadiya on 4/9/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreVideo/CoreVideo.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import "DGActivityIndicatorView.h"


@protocol ReloadVideoDelegate <NSObject>

-(void)reloadTableView;

@end


@interface CreateVideoView : UIViewController
@property (strong, nonatomic) NSString *FolderName;
@property (strong, nonatomic) id <ReloadVideoDelegate> delegate;
@property (strong, nonatomic) DGActivityIndicatorView *activitiView;
@end
