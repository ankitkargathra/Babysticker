//
//  ButtonFont.m
//  BabySticker
//
//  Created by Ankit on 03/04/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import "ButtonFont.h"

@implementation ButtonFont


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(3, 3);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
}


@end
