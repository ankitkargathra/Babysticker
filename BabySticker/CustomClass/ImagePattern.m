//
//  ImagePattern.m
//  BabySticker
//
//  Created by Ankit on 21/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import "ImagePattern.h"

@implementation ImagePattern

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self SetupUI];
}


-(void)prepareForInterfaceBuilder{
    [self SetupUI];
}

-(void)SetupUI{
    self.layer.cornerRadius = self.redious;
//    self.layer.borderWidth=self.borderWidth;
    //    self.backgroundColor = self.backgroundColor;
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
}

@end
