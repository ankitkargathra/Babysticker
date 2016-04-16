//
//  HomeScreenViewController.m
//  BabySticker
//
//  Created by Ankit on 11/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "AppDelegate.h"


@interface HomeScreenViewController () <GADBannerViewDelegate>
@property(nonatomic, strong) GADBannerView *bannerView;
@end

@implementation HomeScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
//    self.bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, self.view.frame.size.height)];
   
   self.bannerView=[[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    self.bannerView.frame = CGRectMake(self.bannerView.frame.origin.x, self.view.frame.size.height-50, self.view.frame.size.width, self.bannerView.frame.size.height);
    self.bannerView.delegate=self;
    // Replace this ad unit ID with your own ad unit ID.
    self.bannerView.adUnitID = @"ca-app-pub-4854036202579049/6779111217";
    self.bannerView.rootViewController = self;
    
    GADRequest *request = [GADRequest request];
    // Requests test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made. GADBannerView automatically returns test ads when running on a
    // simulator.
    request.testDevices = @[kGADSimulatorID];
     [self.bannerView loadRequest:request];
    
    [AppDel.window addSubview:self.bannerView];
    
   
    
    
    // Do any additional setup after loading the view.
}

//************************************************************************//
//***********************# GADBannerView mathod  #*****************************//
//************************************************************************//

#pragma mark - __________GADBannerView method____________


- (void)adViewDidReceiveAd:(GADBannerView *)bannerView
{
    NSLog(@"Load");
}

- (void)adView:(GADBannerView *)adView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adView:didFailToReceiveAdWithError: %@", error.localizedDescription);
}

//************************************************************************//
//***********************# ---------------  #*****************************//
//************************************************************************//



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//************************************************************************//
//***********************# IBAction mathod  #*****************************//
//************************************************************************//

#pragma mark - IBAction method

-(IBAction)homeScreensBtnPress:(UIButton *)sender {
    
    if (sender.tag == kCameraButton) {
        BeforeStartViewController *beforeViewObj = StoryBoard(@"BeforeStartViewController")
        PushViewController(beforeViewObj)
    } else if (sender.tag == kFolderButton) {
        GallaryViewController *gallaryViewObj = StoryBoard(@"GallaryViewController")
        PushViewController(gallaryViewObj)
    } else if (sender.tag == kCartButton) {
        CartAndIntroViewController *cartViewObj = StoryBoard(@"CartAndIntroViewController")
        PushViewController(cartViewObj)
    } else if (sender.tag == kSettingButton) {
        SettingViewController *settingViewObj = StoryBoard(@"SettingViewController")
        PushViewController(settingViewObj)
    }
}



//************************************************************************//
//***********************# ---------------  #*****************************//
//************************************************************************//


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
