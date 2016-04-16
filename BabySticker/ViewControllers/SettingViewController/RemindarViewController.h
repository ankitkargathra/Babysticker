//
//  RemindarViewController.h
//  BabySticker
//
//  Created by Pratik kukadiya on 4/7/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TxtField.h"

@interface RemindarViewController : UIViewController
{
    IBOutlet UIButton *btnWeek,*btnMonth,*btnYear;
    IBOutlet UILabel *lblFromDate,*lblTodate;
    IBOutlet UITextField *txtMessage;
    
    
    NSDate* selectedDate;
    BOOL ISFromDdate;
    IBOutlet TxtField *txtFrom;
    IBOutlet TxtField *txtTo;
}

@end
