//
//  SOSCharityDetailViewController.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/9/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSCharityDetailViewController.h"

@interface SOSCharityDetailViewController ()

@end

@implementation SOSCharityDetailViewController
- (id) initWithCharity:(SOSCharity*)charity
{
    self=[self initWithNibName:@"SOSCharityDetailViewController" bundle:nil];
    if(self)
    {
        self.charity=charity;
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
  UIImageView * iv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FemaleSoldier.jpg"]];
    [self.view addSubview:iv];
   
    UIToolbar * tb=[[UIToolbar alloc] initWithFrame:self.view.bounds];
    tb.barStyle=UIBarStyleBlackTranslucent;

    [self.view addSubview:tb];
   [self.view sendSubviewToBack:tb];
    [self.view sendSubviewToBack:iv];
    self.nameLabel.text=self.charity.name;
    self.descriptionTextView.text=self.charity.charityDescription;
    self.pointsLabel.text=[NSString stringWithFormat:@"%d",self.charity.donated_points];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
