//
//  LanguagesViewController.m
//  BabySticker
//
//  Created by Ankit on 30/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import "LanguagesViewController.h"
#import "AppDelegate.h"


@interface LanguagesViewController ()
{
    IBOutlet UILabel *lblNavigationTitle;
}

@end

@implementation LanguagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    arrLanguage = [[NSMutableArray alloc]init];
    
    [arrLanguage addObject:@"English"];
    [arrLanguage addObject:@"French"];
    [arrLanguage addObject:@"Spanish"];
    [arrLanguage addObject:@"Arabic"];
    [arrLanguage addObject:@"Bengali"];
    [arrLanguage addObject:@"German"];
    [arrLanguage addObject:@"Hindi"];
    [arrLanguage addObject:@"Japanese"];
    [arrLanguage addObject:@"Portuguese"];
    [arrLanguage addObject:@"Punjabi"];
    [arrLanguage addObject:@"Russian"];
    
    [self.tblObj setContentInset:UIEdgeInsetsMake(0, 0, 50, 0)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    lblNavigationTitle.text =[UtilityClass runTimeLocalizedStringForKey:@"Keylanguages"];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [arrLanguage objectAtIndex:indexPath.row];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AppDelegate *appdelegate =  ((AppDelegate *)[[UIApplication sharedApplication] delegate]);
    appdelegate.strSelectedLang = @"";
    AppDel.strSelectedLang = @"";
    
    switch (indexPath.row)
    {
        case ENGLSIH_LANGUAGE:
            AppDel.strSelectedLang = @"en";
            break;
        case FRENCH_LANGUAGE:
            AppDel.strSelectedLang=@"fr";
            break;
        case SPANISH_LANGUAGE:
            AppDel.strSelectedLang=@"es";
            break;
        case ARABIC_LANGUAGE:
            AppDel.strSelectedLang=@"ar";
            break;
        case GERMAN_LANGUAGE:
            AppDel.strSelectedLang=@"de";
            break;
        case JAPANESE_LANGUAGE:
            AppDel.strSelectedLang=@"ja";
            break;
        case BRAZIL_LANGUAGE:
            AppDel.strSelectedLang=@"pt-BR";
            break;
        case RUSSIAN_LANGUAGE:
            AppDel.strSelectedLang=@"ru";
            break;
        case HINDI_LANGUAGE:
            AppDel.strSelectedLang=@"hi-IN";
            break;
        case PANJABI_LAANGUAGE:
            AppDel.strSelectedLang=@"pa-IN";
            break;
        case BANGALI_LANGUAGE:
            AppDel.strSelectedLang=@"bn-IN";
            break;
        
        default:
            break;
    }
    
    [UtilityClass SaveUserDefaultValue:AppDel.strSelectedLang key:SELECTED_LANG];
    lblNavigationTitle.text =[UtilityClass runTimeLocalizedStringForKey:@"Keylanguages"];
    
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrLanguage.count;
}

-(IBAction)backButtonPress:(id)sender {
    //[self.navigationController popViewControllerAnimated:YES];
    PopCurrentViewController
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
