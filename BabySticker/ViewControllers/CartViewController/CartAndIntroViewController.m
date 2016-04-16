//
//  CartAndIntroViewController.m
//  BabySticker
//
//  Created by Ankit on 21/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import "CartAndIntroViewController.h"

@interface CartAndIntroViewController ()

@end

@implementation CartAndIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrSreens = [[NSArray alloc]initWithObjects:@"i1.png",@"i2.png", nil];
    pageControl.numberOfPages = arrSreens.count;
    
    scrollObj.contentSize = CGSizeMake(self.view.frame.size.width * arrSreens.count, self.view.frame.size.height);
    scrollObj.pagingEnabled = YES;
    
    int x = 0;
    for (int i = 0 ; i < arrSreens.count; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, scrollObj.frame.size.width, scrollObj.frame.size.height)];;
        x = x + imgView.frame.size.width;
        [imgView setImage:[UIImage imageNamed:[arrSreens objectAtIndex:i]]];
        [scrollObj addSubview:imgView];
    }
    
    // Do any additional setup after loading the view.
    
}

//************************************************************************//
//*********************# ScrollView mathod  #*****************************//
//************************************************************************//

#pragma mark - --------------scrollview delegate method------------

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int indexOfPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    //your stuff with index
    
    
    pageControl.currentPage = indexOfPage;
    
    NSLog(@"Index - %d",indexOfPage);
    
}

//************************************************************************//
//***********************# IBAction mathod  #*****************************//
//************************************************************************//

#pragma mark - --------------IBAction method------------

-(IBAction)backButtonPress:(id)sender {
    //[self.navigationController popViewControllerAnimated:YES];
    PopCurrentViewController
}
//************************************************************************//
//***********************# ---------------  #*****************************//
//************************************************************************//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
