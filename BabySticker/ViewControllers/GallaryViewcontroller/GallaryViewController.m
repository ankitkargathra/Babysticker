//
//  GallaryViewController.m
//  BabySticker
//
//  Created by Ankit on 12/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import "GallaryViewController.h"
#import "FolderCell.h"

@interface GallaryViewController () <UIAlertViewDelegate>
{
    IBOutlet UILabel *lblNAvigationTitle;
}

@end

@implementation GallaryViewController

@synthesize arrFloderName;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrFloderName = [[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view.

    //get All list of folder
    [self GetFolder];

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    lblNAvigationTitle.text = [UtilityClass runTimeLocalizedStringForKey:@"Keyfolders"];
    

    [btnAddFolder layoutIfNeeded];
    [btnAddFolder setNeedsUpdateConstraints];
    [btnAddFolder updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionLayoutSubviews animations:^{
        btnPlusContrain.constant = 50;
        [btnAddFolder layoutIfNeeded];
    } completion:nil];
}

//************************************************************************//
//********************# CollectionView mathod  #**************************//
//************************************************************************//

#pragma mark - CollectionView datasource and delegate


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrFloderName.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FolderCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"folderCell" forIndexPath:indexPath];

    UILabel *lbl = (UILabel *)[cell viewWithTag:1];
    
    lbl.text = [[arrFloderName objectAtIndex:indexPath.row] capitalizedString];
//    [cell setBackgroundColor:[UIColor redColor]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}
-(void)GetFolder
{
    arrFloderName=[[UtilityClass GetDocumentDirectoryFolderList] mutableCopy];
    [collectionViewObj reloadData];
} 

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotosAndVideoViewController *photoViewObj = StoryBoard(@"PhotosAndVideoViewController")
    photoViewObj.strFolderName = [arrFloderName objectAtIndex:indexPath.row];
    PushViewController(photoViewObj)
}



//************************************************************************//
//***********************# ---------------  #*****************************//
//************************************************************************//


//************************************************************************//
//***********************# IBAction mathod  #*****************************//
//************************************************************************//

#pragma mark - IBAction method


-(IBAction)btnAddFolderPress:(id)sender {

    UIAlertView *alerView = [[UIAlertView alloc]init];
    alerView.alertViewStyle = UIAlertViewStylePlainTextInput;
    alerView.title = @"Enter Folder Name";
    [alerView addButtonWithTitle:@"Cancel"];
    [alerView addButtonWithTitle:@"OK"];
    alerView.delegate = self;
    [alerView show];
}




-(IBAction)backButtonPress:(id)sender {
    //[self.navigationController popViewControllerAnimated:YES];
    PopCurrentViewController
}

//************************************************************************//
//********************# AlertViewDelegate mathod  #***********************//
//************************************************************************//

#pragma mark ______________AlertViewDelegate method________________
#pragma mark ______________Pratk________________

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        
        if(![[UtilityClass trimFolderName:[alertView textFieldAtIndex:0].text] isEqualToString:@""]){
            BOOL IsFolderCreate=[UtilityClass createDocumentDirectory:[[alertView textFieldAtIndex:0]text]];
            
            if (!IsFolderCreate)
            {
                
                [UtilityClass showAlert:@"Folder name is Already exist"];
            } else {
                [self GetFolder];
            }
            
        } else {
            [UtilityClass showAlert:@"Please enter folder name"];
        }
        
    }
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
