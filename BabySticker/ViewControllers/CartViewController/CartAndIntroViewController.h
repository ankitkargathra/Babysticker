//
//  CartAndIntroViewController.h
//  BabySticker
//
//  Created by Ankit on 21/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartAndIntroViewController : UIViewController
{
    IBOutlet UIScrollView *scrollObj;
    NSArray *arrSreens;
    __weak IBOutlet UIPageControl *pageControl;
}
@end
