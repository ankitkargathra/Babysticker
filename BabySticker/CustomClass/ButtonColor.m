//
//  ButtonColor.m
//  BabySticker
//
//  Created by Ankit on 19/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import "ButtonColor.h"

@implementation ButtonColor


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self SetupUI];
}


-(void)prepareForInterfaceBuilder{
    [self SetupUI];
}

-(void)SetupUI{
    self.layer.cornerRadius = self.redious;
    self.layer.borderWidth=self.borderWidth;
//    self.backgroundColor = self.backgroundColor;
    self.clipsToBounds = YES;
    
}
@end
