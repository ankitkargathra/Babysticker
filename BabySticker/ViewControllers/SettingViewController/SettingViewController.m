//
//  SettingViewController.m
//  BabySticker
//
//  Created by Ankit on 12/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import "SettingViewController.h"
#import "LanguagesViewController.h"
#import "RemindarViewController.h"

@interface SettingViewController ()
{
    IBOutlet UILabel *lblNavigationTitle;
    IBOutlet UILabel *lblReminder;
    IBOutlet UILabel *lblShare;
    IBOutlet UILabel *lblContactUs;
    IBOutlet UILabel *lblLanguage;
    IBOutlet UILabel *lblMoreApps;
    IBOutlet UILabel *lblRateUs;
    IBOutlet UILabel *lblSharePhoto;
    IBOutlet UILabel *lblFollowUs;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    lblNavigationTitle.text = [UtilityClass runTimeLocalizedStringForKey:@"Keysetting"];
    lblReminder.text = [UtilityClass runTimeLocalizedStringForKey:@"Keyreminder"];
    lblShare.text = [UtilityClass runTimeLocalizedStringForKey:@"Keyshare"];
    lblContactUs.text = [UtilityClass runTimeLocalizedStringForKey:@"Keycontactus"];
    lblLanguage.text = [UtilityClass runTimeLocalizedStringForKey:@"Keylanguages"];
    lblMoreApps.text = [UtilityClass runTimeLocalizedStringForKey:@"Keymoreapps"];
    lblRateUs.text = [UtilityClass runTimeLocalizedStringForKey:@"Keyrateus"];
    lblSharePhoto.text = [UtilityClass runTimeLocalizedStringForKey:@"Keysharephotomessage"];
    lblFollowUs.text = [UtilityClass runTimeLocalizedStringForKey:@"Keyfollowus"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//************************************************************************//
//***********************# IBAction mathod  #*****************************//
//************************************************************************//

#pragma mark - IBAction method
- (IBAction)btnLanguage:(UIButton *)sender {
    
    
    LanguagesViewController *labguageViewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"LanguagesViewController"];
    [self.navigationController pushViewController:labguageViewObj animated:YES];
    
}


-(IBAction)reiminderButtonPress:(UIButton *)sender{

    RemindarViewController *reminderViewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"RemindarViewController"];
    [self.navigationController pushViewController:reminderViewObj animated:YES];
    
}


- (IBAction)shareButton:(UIButton *)sender
{
    NSString *textToShare = @"Look at this awesome website for aspiring iOS Developers!";
    NSURL *myWebsite = [NSURL URLWithString:@"http://www.codingexplorer.com/"];
    
    NSArray *objectsToShare = @[textToShare, myWebsite];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
   
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:activityVC animated:YES completion:nil];
    
}

-(IBAction)backButtonPress:(id)sender {
    //[self.navigationController popViewControllerAnimated:YES];
    PopCurrentViewController
}

-(IBAction)openUrl:(UIButton *)sender {
    if (sender.tag == 1) {
        [UtilityClass openUrlLink:@"https://www.facebook.com/monthstickersforbabymilestones/"];
    } else  {
        [UtilityClass openUrlLink:@"https://www.instagram.com/monthstickersforbabymilestones/"];
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
