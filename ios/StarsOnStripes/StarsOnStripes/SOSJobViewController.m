//
//  SOSJobViewController.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/9/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSJobViewController.h"

@interface SOSJobViewController ()

@end

@implementation SOSJobViewController
- (id) initWithJob:(SOSJob*)job
{
    self=[self initWithNibName:@"SOSJobViewController" bundle:nil];
    if(self)
    {
        self.job=job;
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text=self.job.title;
    self.descriptionTextView.text=self.job.description;
    self.addressLabel.text=self.job.business.address;
    self.businessLabel.text=self.job.business.name;
    self.emailLabel.text=self.job.contact_email;
    self.phoneLabel.text=self.job.contact_phone;
    if([self.job.contact_link length]>0)
    {
        self.urlLabel.text=self.job.contact_link;
    }
    else
        self.urlLabel.text=self.job.business.url;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
