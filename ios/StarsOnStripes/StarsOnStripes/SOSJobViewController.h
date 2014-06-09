//
//  SOSJobViewController.h
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/9/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOSJob.h"

@interface SOSJobViewController : UIViewController

@property(nonatomic,strong) IBOutlet UILabel * titleLabel;
@property(nonatomic,strong) IBOutlet UILabel * categoryLabel;
@property(nonatomic,strong) IBOutlet UILabel * businessLabel;
@property(nonatomic,strong) IBOutlet UILabel * addressLabel;
@property(nonatomic,strong) IBOutlet UILabel * urlLabel;
@property(nonatomic,strong) IBOutlet UILabel * emailLabel;
@property(nonatomic,strong) IBOutlet UILabel * phoneLabel;
@property(nonatomic,strong) IBOutlet UILabel * linkLabel;

@property(nonatomic,strong) IBOutlet UITextView * descriptionTextView;
@property(nonatomic,strong) SOSJob * job;

- (id) initWithJob:(SOSJob*)job;
- (IBAction)share:(id)sender;
- (IBAction)getDirections:(id)sender;

@end
