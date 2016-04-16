//
//  EditPhotoViewController.h
//  BabySticker
//
//  Created by Ankit on 13/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectStickerViewController.h"


@interface EditPhotoViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate>
{
    IBOutlet UIImageView *imgEditView;
    IBOutlet UIView *viewFilter;;
    __weak IBOutlet NSLayoutConstraint *filterTralingConstail;
    BOOL setFilterViewHide;
    
   
    UIImage *blackAndWhiteImage;
    NSMutableArray *arrSticker;
}

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *foderName;
@property (strong, nonatomic) NSMutableArray *arrFloderName;
@property (strong ,nonatomic) IBOutlet UICollectionView *collectionViewObj;
@end
