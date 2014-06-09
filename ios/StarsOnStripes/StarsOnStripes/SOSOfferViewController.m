//
//  SOSOfferViewController.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/9/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSOfferViewController.h"
#import <MapKit/MapKit.h>

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
- (IBAction)share:(id)sender
{
    NSMutableArray *sharingItems = [NSMutableArray new];

    NSString * offerMessage=[NSString stringWithFormat:@"<html><body>Here is a great offer from <a href=\"http://www.starsonstripes.com\">StarsOnStripes</a>:<br><h2>%@</h2>%@<br><h3>%@</h3>%@</body></html>",self.offer.business.name,self.offer.business.address,self.offer.title,self.offer.description];
    
    [sharingItems addObject:offerMessage];

    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    
    [activityController setValue:[NSString stringWithFormat:@"StarsOnStripes Offer: %@: %@",self.offer.business.name,self.offer.title] forKey:@"Subject"];
    
    [self presentViewController:activityController animated:YES completion:nil];
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
    
    
        UIBarButtonItem * shareButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
    
    self.navigationItem.rightBarButtonItem = shareButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getDirections:(id)sender
{
    CLLocationCoordinate2D latLng;
    latLng.latitude=self.offer.business.latitude;
    latLng.longitude = self.offer.business.longitude;
    
    MKPlacemark* place = [[MKPlacemark alloc] initWithCoordinate: latLng addressDictionary: nil];
    MKMapItem* destination = [[MKMapItem alloc] initWithPlacemark: place];
    destination.name = self.offer.business.name;
    
    NSArray* items = [[NSArray alloc] initWithObjects: destination, nil];
    NSDictionary* options = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 MKLaunchOptionsDirectionsModeDriving, 
                                 MKLaunchOptionsDirectionsModeKey, nil];
    [MKMapItem openMapsWithItems: items launchOptions: options];
}

@end
