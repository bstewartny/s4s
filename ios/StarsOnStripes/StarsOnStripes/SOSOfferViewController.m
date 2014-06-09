//
//  SOSOfferViewController.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/9/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSOfferViewController.h"

@interface SOSOfferViewController ()

@end

@implementation SOSOfferViewController

- (id) initWithOffer:(SOSOffer*)offer
{
    self=[self initWithNibName:@"SOSOfferViewController" bundle:nil];
    if(self)
    {
        self.offer=offer;
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
    
        self.titleLabel.text=self.offer.title;
        self.descriptionTextView.text=self.offer.description;
        self.businessLabel.text=self.offer.business.name;
        self.addressLabel.text=self.offer.business.address;
        self.urlLabel.text=self.offer.business.url;
        // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
