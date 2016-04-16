//
//  TxtField.h
//  BabySticker
//
//  Created by Ankit on 19/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface TxtField : UITextField

@property (nonatomic) IBInspectable CGFloat redious;
@property (nonatomic ,strong) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable NSInteger borderWidth;
@property (nonatomic) IBInspectable NSInteger paddingLeft;
@property (nonatomic ,strong) IBInspectable NSString *imageName;
@property (nonatomic ,strong) IBInspectable UIColor *imageBg;
@property (nonatomic) IBInspectable NSInteger x;
@property (nonatomic) IBInspectable NSInteger y;
@property (nonatomic) IBInspectable NSInteger h;
@property (nonatomic) IBInspectable NSInteger w;
@property (strong, nonatomic) IBInspectable UIColor *TextBgColor;
@property (nonatomic) IBInspectable float opecity;

@end
