//
//  SOSLoginViewController.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/10/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSLoginViewController.h"
#import "SOSAppDelegate.h"

@interface SOSLoginViewController ()

@end

@implementation SOSLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)signIn:(id)sender{
    NSLog(@"signIn");
   [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)signUp:(id)sender{
    NSLog(@"signUp");
    [((SOSAppDelegate*)[[UIApplication sharedApplication] delegate]) showRegisterForm];
    
}
- (IBAction)forgotPassword:(id)sender{

    NSLog(@"forgotPassword");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView * accessoryView=[self createAccessoryView];
    // Do any additional setup after loading the view from its nib.
    self.username.inputAccessoryView=accessoryView;
    self.password.inputAccessoryView=accessoryView;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldShouldBeginEditing");
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing");
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSLog(@"textFieldShouldEndEditing");
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidEndEditing");
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"shouldChangeCharactersInRange");
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    NSLog(@"textFieldShouldClear");
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textFieldShouldReturn");
    if(textField==self.username){
        [self.password becomeFirstResponder];
    }
    if(textField==self.password)
    {
        [self signIn:textField];
    }
    return YES;
}

- (UIView*)createAccessoryView
{
    UIToolbar * toolbar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 24)];
    toolbar.barStyle=UIBarStyleBlackTranslucent;

    UIButton * bn=[UIButton buttonWithType:UIButtonTypeSystem];
    
    [bn setTitle:@"Forgot password?" forState:UIControlStateNormal];
    [[bn titleLabel] setFont:[UIFont systemFontOfSize:15.0]];
    [bn sizeToFit];
    [bn addTarget:self action:@selector(forgotPassword:) forControlEvents:UIControlEventTouchUpInside];
   
    bn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    UIBarButtonItem * forgotPassword=[[UIBarButtonItem alloc] initWithCustomView:bn];
    UIBarButtonItem * seperator=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    bn=[UIButton buttonWithType:UIButtonTypeSystem];
    [bn setTitle:@"Register" forState:UIControlStateNormal];
    [[bn titleLabel] setFont:[UIFont systemFontOfSize:15.0]];
    [bn sizeToFit];
    [bn addTarget:self action:@selector(signUp:) forControlEvents:UIControlEventTouchUpInside];
    bn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    UIBarButtonItem * signUp=[[UIBarButtonItem alloc] initWithCustomView:bn];
    
    toolbar.items=@[signUp,seperator,forgotPassword];
    return toolbar;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
