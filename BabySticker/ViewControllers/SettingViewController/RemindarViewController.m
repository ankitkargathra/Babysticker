//
//  RemindarViewController.m
//  BabySticker
//
//  Created by Pratik kukadiya on 4/7/16.
//  Copyright © 2016 Ankit. All rights reserved.
//

#import "RemindarViewController.h"
#import "NSDate+DayNumber.h"


@interface RemindarViewController () <UITextFieldDelegate>
{
    UIDatePicker *datePicker;
    NSDate *startDate;
    NSDate *endDate;
}

@end

@implementation RemindarViewController

#pragma mark-Life Cycel...

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//   NSString *start = @"2010-09-01";
//    NSString *end = @"2010-12-01";
//    
//    NSDateFormatter *f = [[NSDateFormatter alloc] init];
//    [f setDateFormat:@"yyyy-MM-dd"];
//    NSDate *startDate = [f dateFromString:start];
//    NSDate *endDate = [f dateFromString:end];
//    
//    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
//                                                        fromDate:startDate
//                                                          toDate:endDate
//                                                         options:NSCalendarWrapComponents];
//    
//    NSLog(@"%ld", [components day]);
   
    datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [txtTo setInputView:datePicker];
    [txtFrom setInputView:datePicker];
}

-(void)updateTextField:(UIDatePicker *)dtpicker {
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark-Button Click Events...

-(IBAction)backButtonPress:(id)sender
{
    PopCurrentViewController
}

//Radio Button Selection Methods...

-(void)DselectAllButton
{
    btnMonth.selected=btnWeek.selected=btnYear.selected=NO;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(IBAction)BtnSelctOption:(UIButton *)sender
{
    [self DselectAllButton];
    
    if (sender.tag==1)
    {
        btnWeek.selected=YES;
    }
    else if (sender.tag==2)
    {
        btnMonth.selected=YES;
    }
    else
    {
        btnYear.selected=YES;
    }
}

-(IBAction)BtnOpenCalendar:(UIButton *)sender
{
//    [self OpenDatePicker];
    
    if (sender.tag==1)
    {
        ISFromDdate=YES;
    }
    else
    {
        ISFromDdate=NO;
    }
}

-(IBAction)BtnDoneClickEvent:(id)sender
{
    
    if ([lblFromDate.text isEqualToString:@"DD/MM/YYYY"])
    {
        [UtilityClass showAlert:@"Please Select FROMDATE"];
        return;
    }
    else if ([lblTodate.text isEqualToString:@"DD/MM/YYYY"])
    {
        [UtilityClass showAlert:@"Please Select TODATE"];
        return;
    }
    
    NSTimeInterval sec = [endDate timeIntervalSinceDate:startDate];
    NSInteger days = [startDate numberOfDaysUntil:endDate];
    NSLog(@"%ld",(long)days);
    NSLog(@"%f",sec);
    
    
}

#pragma mark-Date Picker Methods...

//-(void)OpenDatePicker
//{
//    datePickerView = [[TDDatePickerController alloc]
//                                              initWithNibName:@"TDDatePickerController"
//                                              bundle:nil];
//    datePickerView.delegate = self;
//    datePickerView.coverView.backgroundColor=[UIColor whiteColor];
//    [self presentSemiModalViewController:datePickerView];
//}
//
//-(void)datePickerSetDate:(TDDatePickerController*)viewController
//{
//    
//    if (ISFromDdate)
//    {
//        lblFromDate.text=[UtilityClass DateFormat:viewController.datePicker.date];
//        selectedDate=viewController.datePicker.date;
//    }
//    else
//    {
//        [UtilityClass GenerateSechduleDate:selectedDate :viewController.datePicker.date :Remindar_MONTH];
//        
//        if (![UtilityClass CheckValidDate:selectedDate :viewController.datePicker.date :Remindar_MONTH])
//            return;
//
//        lblTodate.text=[UtilityClass DateFormat:viewController.datePicker.date];
//    }
//
//    [self dismissSemiModalViewController:datePickerView];
//}
//
//-(void)datePickerClearDate:(TDDatePickerController*)viewController
//{
//    if (ISFromDdate)
//    {
//        lblFromDate.text=@"DD/MM/YYYY";
//    }
//    else
//    {
//        lblTodate.text=@"DD/MM/YYYY";
//    }
//}
//
//-(void)datePickerCancel:(TDDatePickerController*)viewController
//{
//    [self dismissSemiModalViewController:datePickerView];
//}
//

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    if(textField.tag != 3){
        if ([textField.text isEqualToString:@""]) {
            textField.text = @"DD/MM/YYYY";
        }
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd-MMM-yyyy";
        NSLog(@"%@",[dateFormatter stringFromDate:datePicker.date]);
        if (textField.tag == 1) {
            startDate = datePicker.date;
            datePicker.minimumDate = datePicker.date;
            textField.text = [dateFormatter stringFromDate:datePicker.date];
        } else {
            endDate = datePicker.date;
            datePicker.minimumDate = [NSDate date];
            textField.text = [dateFormatter stringFromDate:datePicker.date];
        }
       
        
    }
}


@end
