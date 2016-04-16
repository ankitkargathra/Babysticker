//
//  GallaryViewController.h
//  BabySticker
//
//  Created by Ankit on 12/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotosAndVideoViewController.h"

@interface GallaryViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate>
{
    
    __weak IBOutlet NSLayoutConstraint *btnPlusContrain;
    IBOutlet UICollectionView *collectionViewObj;
    IBOutlet UIButton *btnAddFolder;

}

@property (strong, nonatomic) NSMutableArray *arrFloderName;
@end
