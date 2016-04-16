//
//  SelectStickerViewController.h
//  BabySticker
//
//  Created by Ankit on 15/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StickerImageDelegate <NSObject>

-(void)getImageSticker:(UIImage *)image;

@end

@interface SelectStickerViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate>
{
    IBOutlet UIImageView *imgView;
    IBOutlet UIImageView *imgViewBG;
    IBOutlet UIImageView *imgInnerCircle;
    UIColor *colorInnserShape;
    NSString *strInnerShapeImg;
    UIColor *selectedColor; // set Select color for pattern image
    UIColor *selectedColorBg;
    NSString *strImgName; // set Image name
    
    IBOutlet UIView *viewMenu;
    IBOutlet UIScrollView *scrollObj;
    IBOutlet UIScrollView *scrollObjMenuItems;
    
    NSArray *arrMenuName;
    
    UILabel *lblSlider;
    int oldIndex;
    CGRect oldRect;
    
    IBOutlet UIView *view1,*view2,*view3,*view4,*view5,*view6,*view7,*view8,*view9,*view10;
    
    __weak IBOutlet UICollectionViewCell *CollectionCell0;
    __weak IBOutlet UICollectionView *collectionObj;
    __weak IBOutlet UILabel *lblDays;
    __weak IBOutlet UILabel *lblMonthText;
    __weak IBOutlet UISlider *lblFontSlider;
    __weak IBOutlet UISwitch *switchNumber;
    
    CGFloat fontSize;
//    NSString *patternIndex;
   // NSString *strImgName;
    int patternIndex;
}

@property (strong, nonatomic) id <StickerImageDelegate> delegate;


@end
