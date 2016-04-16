//
//  PhotosAndVideoViewController.h
//  BabySticker
//
//  Created by Ankit on 20/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosAndVideoViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    IBOutlet UILabel *lblTitle;
    
    IBOutlet UICollectionView *collectionViewObj;
    IBOutlet UICollectionView *collectionViewObj1;
    
    NSArray *arrImage;
    NSArray *ArrayVideo;
}
@property (strong, nonatomic) NSString *strFolderName;
@property (strong, nonatomic)IBOutlet UIButton *btnVideo;
@end
