//
//  LanguagesViewController.h
//  BabySticker
//
//  Created by Ankit on 30/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface LanguagesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arrLanguage;
}
@property (strong, nonatomic) IBOutlet UITableView *tblObj;

@end
