//
//  Constant.h
//  BabySticker
//
//  Created by Ankit on 12/03/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#define AppDel ((AppDelegate *)[[UIApplication sharedApplication] delegate])

//*****************************************************************************************//
// StoryBoard and Push,Pop ViewController Define
//*****************************************************************************************//

#define StoryBoard(indentifire) [self.storyboard instantiateViewControllerWithIdentifier:indentifire];
#define PopCurrentViewController [self.navigationController popViewControllerAnimated:YES];
#define PushViewController(viewControllerObj) [self.navigationController pushViewController:viewControllerObj animated:YES];

//*****************************************************************************************//

//*****************************************************************************************//

#define SELECTED_LANG @"selectedLanguage"

#define ENGLSIH_LANGUAGE   0
#define FRENCH_LANGUAGE    1
#define SPANISH_LANGUAGE   2
#define ARABIC_LANGUAGE    3
#define BANGALI_LANGUAGE   4
#define GERMAN_LANGUAGE    5
#define HINDI_LANGUAGE     6
#define JAPANESE_LANGUAGE  7
#define BRAZIL_LANGUAGE    8
#define PANJABI_LAANGUAGE  9
#define RUSSIAN_LANGUAGE   10

#endif /* Constant_h */
