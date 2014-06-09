//
//  SOSPlaceViewController.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/9/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSPlaceViewController.h"

@interface SOSPlaceViewController ()

@end

@implementation SOSPlaceViewController
- (id) initWithPlace:(SOSPlace*)place;
{
    self=[self initWithNibName:@"SOSPlaceViewController" bundle:nil];
    if(self)
    {
        self.place=place;
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
    self.nameLabel.text=self.place.name;
    self.addressLabel.text=self.place.address;
    self.phoneLabel.text=self.place.phone;
    self.urlLabel.text=self.place.url;
    self.descriptionTextView.text=self.place.description;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
