//
//  SOSJobViewController.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/9/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSJobViewController.h"
#import <MapKit/MapKit.h>

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

- (IBAction)share:(id)sender
{
    NSMutableArray *sharingItems = [NSMutableArray new];

    NSString * jobMessage=[NSString stringWithFormat:@"<html><body>Here is a great job from <a href=\"http://www.starsonstripes.com\">StarsOnStripes</a>:<br><h2>%@</h2>%@<br><h3>%@</h3>%@</body></html>",self.job.business.name,self.job.business.address,self.job.title,self.job.description];
    
    [sharingItems addObject:jobMessage];

    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    
    [activityController setValue:[NSString stringWithFormat:@"StarsOnStripes Job: %@: %@",self.job.business.name,self.job.title] forKey:@"Subject"];
    
    [self presentViewController:activityController animated:YES completion:nil];
}
- (IBAction)getDirections:(id)sender
{
    CLLocationCoordinate2D latLng;
    latLng.latitude=self.job.business.latitude;
    latLng.longitude = self.job.business.longitude;
    
    MKPlacemark* place = [[MKPlacemark alloc] initWithCoordinate: latLng addressDictionary: nil];
    MKMapItem* destination = [[MKMapItem alloc] initWithPlacemark: place];
    destination.name = self.job.business.name;
    
    NSArray* items = [[NSArray alloc] initWithObjects: destination, nil];
    NSDictionary* options = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 MKLaunchOptionsDirectionsModeDriving, 
                                 MKLaunchOptionsDirectionsModeKey, nil];
    [MKMapItem openMapsWithItems: items launchOptions: options];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIImageView * iv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavyFleet.jpg"]];
    [self.view addSubview:iv];
   
   self.blurView=[[UIToolbar alloc] initWithFrame:self.view.bounds];
    self.blurView.barStyle=UIBarStyleBlackTranslucent;
    
    
    [self.view addSubview:self.blurView];
   [self.view sendSubviewToBack:self.blurView];
       [self.view sendSubviewToBack:iv];
    
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
    
        UIBarButtonItem * shareButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
    
    self.navigationItem.rightBarButtonItem = shareButton;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
