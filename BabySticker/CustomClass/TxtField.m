//
//  TxtField.m
//  BabySticker
//
//  Created by Ankit on 19/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import "TxtField.h"

@implementation TxtField


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
    self.layer.borderColor = self.borderColor.CGColor;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _paddingLeft, self.frame.size.height)];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(_x, _y ,_w, _h)];
    [img setBackgroundColor:_imageBg];
    [img setImage:[UIImage imageNamed:_imageName]];
    lbl.backgroundColor = _TextBgColor;
    lbl.layer.opacity = _opecity;
    [self addSubview:lbl];
    [leftView addSubview:img];
    leftView.backgroundColor = [UIColor clearColor];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

@end
