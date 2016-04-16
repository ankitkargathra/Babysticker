//
//  SelectStickerViewController.m
//  BabySticker
//
//  Created by Ankit on 15/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import "SelectStickerViewController.h"

@interface SelectStickerViewController () <UIGestureRecognizerDelegate>
{
    UIImage *imgObj;
    UIImage *imgObjbg;
    __weak IBOutlet UIImageView *imgAccesory;
    UIColor *colorAccesory;
    __weak IBOutlet UIView *viewSticker;
    IBOutlet UILabel *lblSticker;
    IBOutlet UIButton *btnDone;
    IBOutlet UILabel *lblPreview;

}
@end

@implementation SelectStickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//        viewMenu.frame = CGRectMake(0, 0, 2500, 50);
//        NSLog(@"%@",NSStringFromCGRect(viewMenu.frame));
    
    lblDays.text = @"";
    fontSize = 15;
    patternIndex = 1;
    strImgName = @"zigzag";
    colorInnserShape = [UIColor whiteColor];
    strInnerShapeImg = @"inner_shape_2";
    [self setInnerShape:[UIImage imageNamed:strInnerShapeImg] AndColor:colorInnserShape];
    // setup menu view
//    arrMenuName = [[NSArray alloc]initWithObjects:
//                   @"SHAPE",
//                   @"PATTERNS",
//                   @"PATTERN COLOR",
//                   @"PATTERN BACKGROUND COLOR",
//                   @"INSIDE SHAPE",
//                   @"INNER CIRCLE COLOR",
//                   @"NUMBER",
//                   @"NUMBER COLOR",
//                   @"WEEK OR MONTH",
//                   @"CUSTOM TEXT",
//                   @"FONT STYLES",
//                   @"ACCESSORIES",
//                   @"ACCESSORIES COLOR",nil];
    
    arrMenuName = [[NSArray alloc]initWithObjects:
                   [UtilityClass runTimeLocalizedStringForKey:@"Keyshape"],
                   [UtilityClass runTimeLocalizedStringForKey:@"Keypatterns"],
                   [UtilityClass runTimeLocalizedStringForKey:@"Keypattern color"],
                   [UtilityClass runTimeLocalizedStringForKey:@"Keypattern background color"],
                   [UtilityClass runTimeLocalizedStringForKey:@"Keyinside shape"],
                   [UtilityClass runTimeLocalizedStringForKey:@"Keyinner circle color"],
                   [UtilityClass runTimeLocalizedStringForKey:@"Keynumber"],
                   [UtilityClass runTimeLocalizedStringForKey:@"Keynumber color"],
                   [UtilityClass runTimeLocalizedStringForKey:@"Keyweekormonth"],
                   [UtilityClass runTimeLocalizedStringForKey:@"Keycustom text"],
                   [UtilityClass runTimeLocalizedStringForKey:@"Keyfont styles"],
                   [UtilityClass runTimeLocalizedStringForKey:@"Keyaccessories"],
                   [UtilityClass runTimeLocalizedStringForKey:@"Keyaccessoriescolor"],nil];

    
    [self setupTopMenuBar];
    [self setSliderLblWithButtonTag:0];
        
//    UIImage *tiledImage = [UIImage imageNamed:@"Pattern_1.png"];
//    imgView.backgroundColor = [UIColor colorWithPatternImage:tiledImage];
    self.view.clipsToBounds = YES;
    imgView.clipsToBounds = YES;
    
    selectedColor = [UIColor blackColor];
    selectedColorBg = [UIColor whiteColor];
    imgObj = [UIImage imageNamed:@"zigzag.png"];
    imgObjbg = [UIImage imageNamed:@"zigzagbg.png"];
    
    [self setImage:imgObj andColor:selectedColor andBgImage:imgObjbg andBgColor:selectedColorBg];
    [self setInnerShape:[UIImage imageNamed:strInnerShapeImg] AndColor:colorInnserShape];

    [scrollObjMenuItems addSubview:view1];
    scrollObjMenuItems.pagingEnabled = YES;
    view1.frame = CGRectMake(0, 0, self.view.frame.size.width, scrollObjMenuItems.frame.size.height);
    
    // create and configure the pinch gesture
//    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureDetected:)];
//    [pinchGestureRecognizer setDelegate:self];
//    [imgAccesory addGestureRecognizer:pinchGestureRecognizer];
//    
//    // create and configure the rotation gesture
//    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGestureDetected:)];
//    [rotationGestureRecognizer setDelegate:self];
//    [imgAccesory addGestureRecognizer:rotationGestureRecognizer];
    
    // creat and configure the pan gesture
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureDetected:)];
    [panGestureRecognizer setDelegate:self];
    [imgAccesory addGestureRecognizer:panGestureRecognizer];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    lblSticker.text = [UtilityClass runTimeLocalizedStringForKey:@"Keysticker"];
    [btnDone setTitle:[UtilityClass runTimeLocalizedStringForKey:@"KeyDone"] forState:UIControlStateNormal];
    lblPreview.text = [UtilityClass runTimeLocalizedStringForKey:@"Keypreview"];
}



- (void)pinchGestureDetected:(UIPinchGestureRecognizer *)recognizer
{
    UIGestureRecognizerState state = [recognizer state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGFloat scale = [recognizer scale];
        [recognizer.view setTransform:CGAffineTransformScale(recognizer.view.transform, scale, scale)];
        [recognizer setScale:1.0];
    }
}

- (void)rotationGestureDetected:(UIRotationGestureRecognizer *)recognizer
{
    UIGestureRecognizerState state = [recognizer state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGFloat rotation = [recognizer rotation];
        [recognizer.view setTransform:CGAffineTransformRotate(recognizer.view.transform, rotation)];
        [recognizer setRotation:0];
    }
}

- (void)panGestureDetected:(UIPanGestureRecognizer *)recognizer
{
    UIGestureRecognizerState state = [recognizer state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [recognizer translationInView:recognizer.view];
        [recognizer.view setTransform:CGAffineTransformTranslate(recognizer.view.transform, translation.x, translation.y)];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

//************************************************************************//
//***********************# Top  Bar mathod  #*****************************//
//************************************************************************//

#pragma mark - --------------Setup Top menu method------------

-(void)setupTopMenuBar {
    int x = 0;
    oldIndex = 0;
    
    lblSlider = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 2)];
    [lblSlider setBackgroundColor:[UIColor whiteColor]];
//    [lblSlider bringSubviewToFront:scrollObj];
    [scrollObj addSubview:lblSlider];
    [scrollObj setBackgroundColor:[UIColor colorWithRed:198.0/225.0 green:89.0/225.0 blue:57.0/225.0 alpha:1]];
    
    
    // add Button
    
    for (int i = 0; i < arrMenuName.count; i++) {
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:14]};
        // NSString class method: boundingRectWithSize:options:attributes:context is
        // available only on ios7.0 sdk.
        CGRect rect = [[arrMenuName objectAtIndex:i] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:attributes
                                                  context:nil];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, rect.size.width + 55, 50)];
        x = x + btn.frame.size.width;
        [scrollObj addSubview:btn];
        [btn setTag:i];
        [btn setTitle:[arrMenuName objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(menuButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
   
    
    scrollObj.contentSize = CGSizeMake(x, 50);
    scrollObjMenuItems.contentSize = CGSizeMake(self.view.frame.size.width * arrMenuName.count, scrollObjMenuItems.frame.size.height);
   
}
//************************************************************************//
//***********************# ---------------  #*****************************//
//************************************************************************//

//************************************************************************//
//***********************# IBAction mathod  #*****************************//
//************************************************************************//

#pragma mark - ---------------IBAction method------------------

-(IBAction)backButtonPress:(id)sender {
    //[self.navigationController popViewControllerAnimated:YES];
    PopCurrentViewController
}

-(IBAction)changeColorOfImg:(UIButton *)sender{
    
//    if (sender.tag == 1) {
        selectedColor = sender.backgroundColor;
    [self setImage:imgObj andColor:selectedColor andBgImage:imgObjbg andBgColor:selectedColorBg];
//    } else {
//        selectedColor = [UIColor colorWithRed:0.5 green:0.7 blue:0.4 alpha:1];
//        [self setImage:strImgName andColor:selectedColor];
//    }
//  
}

- (IBAction)switchInnercircle:(UISwitch *)sender {
    
    if(sender.isOn){
        imgInnerCircle.hidden = YES;
    } else {
        imgInnerCircle.hidden = NO;
    }
    
}


- (IBAction)chengeColorBg:(UIButton *)sender {
    selectedColorBg = sender.backgroundColor;
    [self setImage:imgObj andColor:selectedColor andBgImage:imgObjbg andBgColor:selectedColorBg];
}

- (IBAction)setNumberMonth:(UISwitch *)sender {
    
    if(sender.isOn){
        lblDays.hidden = YES;
    } else {
        lblDays.hidden = NO;
    }
    
}

- (IBAction)setFontSize:(UISlider *)sender {
    
//    [lblMonthText setFont: [lblMonthText.font fontWithSize: [sender.value intvalue]]];
    
    fontSize = sender.value;
    [lblMonthText setFont:[lblMonthText.font fontWithSize:sender.value]];
    
}

- (IBAction)btnInnerShapePress:(UIButton *)sender {
    
    strInnerShapeImg = sender.restorationIdentifier;
    
    [self setInnerShape:[UIImage imageNamed:sender.restorationIdentifier] AndColor:colorInnserShape];
    
}

- (IBAction)btnInnserShapeColor:(UIButton *)sender {
    
    
    colorInnserShape = sender.backgroundColor;
    [self setInnerShape:[UIImage imageNamed:strInnerShapeImg] AndColor:colorInnserShape];
}

-(void)setInnerShape:(UIImage *)image AndColor:(UIColor*)color {
    imgInnerCircle.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [imgInnerCircle setTintColor:color];
}


-(IBAction)selectimage:(UIButton *)sender {
  

    strImgName = sender.restorationIdentifier;
    NSLog(@"%@",sender.restorationIdentifier);
    imgObj = [UIImage imageNamed:[NSString stringWithFormat:@"%@Pattern%d",sender.restorationIdentifier,patternIndex]];
    imgObjbg = [UIImage imageNamed:[NSString stringWithFormat:@"%@bg",sender.restorationIdentifier]];
    [self setImage:imgObj andColor:selectedColor andBgImage:imgObjbg andBgColor:selectedColorBg];

    
}

- (IBAction)btnSelectAccesory:(UIButton *)sender {
    
    imgAccesory.image = [UIImage imageNamed:sender.restorationIdentifier];
    
    
}

- (IBAction)btnAccesoryColor:(UIButton *)sender {
    
    imgAccesory.image = [imgAccesory.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [imgAccesory setTintColor:sender.backgroundColor];
    
}


- (IBAction)btnSelectPatterns:(UIButton *)sender {

    imgObj = [UIImage imageNamed:[NSString stringWithFormat:@"%@Pattern%ld",strImgName,(long)sender.tag]];

    
    patternIndex = (int)sender.tag;
    imgObjbg = [UIImage imageNamed:[NSString stringWithFormat:@"%@bg",strImgName]];
    
    [self setImage:imgObj andColor:selectedColor andBgImage:imgObjbg andBgColor:selectedColorBg];

}

- (IBAction)btnSetNumberColor:(id)sender {
    UIButton *btn = (UIButton *)sender;
    lblDays.textColor = btn.backgroundColor;
}



-(IBAction)menuButtonPress:(UIButton *)btn {
    
    [UtilityClass setMyCustomAnimationView:lblSlider andFrame:CGRectMake(btn.frame.origin.x, 0, btn.frame.size.width, 2)];
    
}

- (IBAction)btnDaysNo:(UIButton *)sender {
    
    lblDays.text = [[sender titleLabel] text];
    
}
- (IBAction)btnlblMonthColorSet:(UIButton *)sender {
    
    lblMonthText.textColor = sender.backgroundColor;
    
}


- (IBAction)btnFontPress:(UIButton *)sender {
    [lblMonthText setFont:[UIFont fontWithName:sender.restorationIdentifier size:fontSize]];
}


-(void)setImage:(UIImage *)imgName andColor:(UIColor *)color andBgImage:(UIImage *)imageBg andBgColor:(UIColor *)bgcolor {
    
    imgView.image = [imgName imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [imgView setTintColor:color];
    
    
    imgViewBG.image = [imageBg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [imgViewBG setTintColor:bgcolor];
    
    //imgView.backgroundColor = [UIColor colorWithPatternImage:[UtilityClass colorizeImage:[UIImage imageNamed:imgName] color:color]];
}


//************************************************************************//
//***********************# ---------------  #*****************************//
//************************************************************************//


//************************************************************************//
//*********************# ScrollView mathod  #*****************************//
//************************************************************************//

#pragma mark - --------------scrollview delegate method------------

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int indexOfPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    //your stuff with index
    
//    [self setSliderLblWithButtonTag:indexOfPage];
    NSLog(@"Index - %d",indexOfPage);
    
    
    for (UIButton *btn in scrollObj.subviews) {
        
        if ([btn isKindOfClass:[UIButton class]]) {
            
            if (btn.tag == indexOfPage) {
                [UtilityClass setMyCustomAnimationView:lblSlider andFrame:CGRectMake(btn.frame.origin.x, 0, btn.frame.size.width, 2)];
                
                if (btn.tag >= 2) {
                    [UtilityClass setMyCustomScrollAnimationView:scrollObj andFrame:CGPointMake(btn.frame.origin.x+btn.frame.size.width - scrollObj.frame.size.width, 0)];
                } else {
                     [UtilityClass setMyCustomScrollAnimationView:scrollObj andFrame:CGPointMake(0, 0)];
                }
                break;
            }
        }
    }
}


-(void)setSliderLblWithButtonTag:(int)buttonTag {
    
    for (UIButton *btn in viewMenu.subviews) {
        
        if ([btn isKindOfClass:[UIButton class]]) {
            if (btn.tag == buttonTag) {
                [UtilityClass setMyCustomAnimationView:lblSlider andFrame:CGRectMake(btn.frame.origin.x, 0, btn.frame.size.width, 2)];
                    NSLog(@"oldIndex - %d newindex - %d",oldIndex,buttonTag);
                if (lblSlider.frame.origin.x + 5 > self.view.frame.size.width) {
                    if (oldIndex < buttonTag) {
                        [UtilityClass setMyCustomScrollAnimationView:scrollObj andFrame:CGPointMake(scrollObj.contentOffset.x+btn.frame.size.width+10, 0)];
                    } else if (oldIndex > buttonTag) {
                        [UtilityClass setMyCustomScrollAnimationView:scrollObj andFrame:CGPointMake(scrollObj.contentOffset.x-oldRect.size.width, 0)];
                    }
                } else {
                    [UtilityClass setMyCustomScrollAnimationView:scrollObj andFrame:CGPointMake(0, 0)];
                }
                oldIndex = buttonTag;
                oldRect = btn.frame;
                break;
            }
            
        }
        
    }
    
    
}

//************************************************************************//
//***********************# ---------------  #*****************************//
//************************************************************************//

//************************************************************************//
//***********************# Collection mathod  #*****************************//
//************************************************************************//

#pragma mark - --------------CollectionView method------------

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return arrMenuName.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *Str = [arrMenuName objectAtIndex:indexPath.row];
    
    /*
     [UtilityClass runTimeLocalizedStringForKey:@"Keyshape"],
     [UtilityClass runTimeLocalizedStringForKey:@"Keypatterns"],
     [UtilityClass runTimeLocalizedStringForKey:@"Keypattern color"],
     [UtilityClass runTimeLocalizedStringForKey:@"Keypattern background color"],
     [UtilityClass runTimeLocalizedStringForKey:@"Keyinside shape"],
     [UtilityClass runTimeLocalizedStringForKey:@"Keyinner circle color"],
     [UtilityClass runTimeLocalizedStringForKey:@"Keynumber"],
     [UtilityClass runTimeLocalizedStringForKey:@"Keynumber color"],
     [UtilityClass runTimeLocalizedStringForKey:@"Keyweekormonth"],
     [UtilityClass runTimeLocalizedStringForKey:@"Keycustom text"],
     [UtilityClass runTimeLocalizedStringForKey:@"Keyfont styles"],
     [UtilityClass runTimeLocalizedStringForKey:@"Keyaccessories"],
     [UtilityClass runTimeLocalizedStringForKey:@"Keyaccessoriescolor"]
     */
    
    if([Str isEqualToString:[UtilityClass runTimeLocalizedStringForKey:@"Keyshape"]]) {
        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellPatterns" forIndexPath:indexPath];
        return cell;
    } else if ([Str isEqualToString:[UtilityClass runTimeLocalizedStringForKey:@"Keypatterns"]]) {
        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellShape" forIndexPath:indexPath];
        return cell;
    }else if ([Str isEqualToString:[UtilityClass runTimeLocalizedStringForKey:@"Keypattern color"]]) {
        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellPatternColor" forIndexPath:indexPath];
        
        return cell;
    } else if ([Str isEqualToString:[UtilityClass runTimeLocalizedStringForKey:@"Keyinside shape"]]) {
        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellInsideShape" forIndexPath:indexPath];
        return cell;
    } else if ([Str isEqualToString:[UtilityClass runTimeLocalizedStringForKey:@"Keyinner circle color"]]) {
        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellInerCircleColor" forIndexPath:indexPath];
        return cell;
    } else if ([Str isEqualToString:[UtilityClass runTimeLocalizedStringForKey:@"Keynumber"]]) {
        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellNumber" forIndexPath:indexPath];
        
        return cell;
    } else if ([Str isEqualToString:[UtilityClass runTimeLocalizedStringForKey:@"Keyweekormonth"]]) {
        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellEorM" forIndexPath:indexPath];
        
        return cell;
    } else if ([Str isEqualToString:[UtilityClass runTimeLocalizedStringForKey:@"Keycustom text"]]) {
        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellCustomTextAndColor" forIndexPath:indexPath];
        
        return cell;
    } else if ([Str isEqualToString:[UtilityClass runTimeLocalizedStringForKey:@"Keyfont styles"]]) {
        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellFont" forIndexPath:indexPath];
        
        return cell;
    } else if ([Str isEqualToString:[UtilityClass runTimeLocalizedStringForKey:@"Keyaccessories"]]) {
        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellAceesory" forIndexPath:indexPath];
        return cell;
    } else if([Str isEqualToString:[UtilityClass runTimeLocalizedStringForKey:@"Keynumber color"]]){
        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellNumberColor" forIndexPath:indexPath];
        return cell;
        
    } else if([Str isEqualToString:[UtilityClass runTimeLocalizedStringForKey:@"Keypattern background color"]]) {
        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellPatternBgColor" forIndexPath:indexPath];
        return cell;
        
    } else {
        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellAcceryColor" forIndexPath:indexPath];
        return cell;
    }

    
    
    
//    if([Str isEqualToString:@"SHAPE"]) {
//        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellPatterns" forIndexPath:indexPath];
//            return cell;
//    } else if ([Str isEqualToString:@"PATTERNS"]) {
//        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellShape" forIndexPath:indexPath];
//        return cell;
//    }else if ([Str isEqualToString:@"PATTERN COLOR"]) {
//        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellPatternColor" forIndexPath:indexPath];
//       
//        return cell;
//    } else if ([Str isEqualToString:@"INSIDE SHAPE"]) {
//         UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellInsideShape" forIndexPath:indexPath];
//        return cell;
//    } else if ([Str isEqualToString:@"INNER CIRCLE COLOR"]) {
//        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellInerCircleColor" forIndexPath:indexPath];
//        return cell;
//    } else if ([Str isEqualToString:@"NUMBER"]) {
//        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellNumber" forIndexPath:indexPath];
//        
//        return cell;
//    } else if ([Str isEqualToString:@"WEEK OR MONTH"]) {
//        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellEorM" forIndexPath:indexPath];
//       
//        return cell;
//    } else if ([Str isEqualToString:@"CUSTOM TEXT"]) {
//         UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellCustomTextAndColor" forIndexPath:indexPath];
//       
//        return cell;
//    } else if ([Str isEqualToString:@"FONT STYLES"]) {
//        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellFont" forIndexPath:indexPath];
//        
//        return cell;
//    } else if ([Str isEqualToString:@"ACCESSORIES"]) {
//        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellAceesory" forIndexPath:indexPath];
//        return cell;
//    } else if([Str isEqualToString:@"NUMBER COLOR"]){
//        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellNumberColor" forIndexPath:indexPath];
//        return cell;
//
//    } else if([Str isEqualToString:@"PATTERN BACKGROUND COLOR"]) {
//        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellPatternBgColor" forIndexPath:indexPath];
//        return cell;
//        
//    } else {
//        UICollectionViewCell *cell = [collectionObj dequeueReusableCellWithReuseIdentifier:@"cellAcceryColor" forIndexPath:indexPath];
//        return cell;
//    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
}


//************************************************************************//
//***********************# ---------------  #*****************************//
//************************************************************************//


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    lblMonthText.text = textField.text;
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)btnWeekAndMonthPreesed:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if(btn.tag == 1) {
        lblMonthText.text = @"Week";
    } else {
        lblMonthText.text = @"Month";
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)doneButtonPress:(UIButton *)sender {
    
    [self.delegate getImageSticker:[self imageWithView:viewSticker]];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


-(UIImage *)imageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
