//
//  SOSRegisterViewController.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/12/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSRegisterViewController.h"

@interface SOSRegisterViewController ()

@end

@implementation SOSRegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)signUp:(id)sender
{}
- (IBAction)statusChange:(id)sender
{}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.formView.layer.cornerRadius=10.0;
    self.formView.layer.shadowOffset=CGSizeMake(0,0);
    self.formView.layer.shadowColor=[[UIColor blackColor] CGColor];
    self.formView.layer.shadowOpacity=0.5;
    self.formView.layer.shadowRadius=10;
   
     
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [@[@"U.S. Army",@"U.S. Navy",@"U.S. Air Force",@"U.S. Marines",@"U.S. Coast Guard"] objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
