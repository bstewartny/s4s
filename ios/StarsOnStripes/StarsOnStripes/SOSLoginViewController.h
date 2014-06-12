//
//  SOSLoginViewController.h
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/10/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOSLoginViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic,strong) IBOutlet UITextField * username;
@property(nonatomic,strong) IBOutlet UITextField * password;
@property(nonatomic,strong) IBOutlet UIButton * forgotPassword;
@property(nonatomic,strong) IBOutlet UIButton * signUp;
- (IBAction)signIn:(id)sender;
- (IBAction)signUp:(id)sender;
- (IBAction)forgotPassword:(id)sender;

@end
