//
//  SOSRegisterViewController.h
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/12/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOSRegisterViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong) IBOutlet UITextField * username;
@property(nonatomic,strong) IBOutlet UITextField * password;
@property(nonatomic,strong) IBOutlet UITextField * confirmPassword;
@property(nonatomic,strong) IBOutlet UIView * formView;
@property(nonatomic,strong) IBOutlet UISegmentedControl * militaryStatus;
@property(nonatomic,strong) IBOutlet UIPickerView * militaryBranch;

- (IBAction)signUp:(id)sender;
- (IBAction)statusChange:(id)sender;

@end
