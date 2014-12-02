//
//  SOSPlaceViewController.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/9/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSPlaceViewController.h"
#import <MapKit/MapKit.h>
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
- (void) viewDidAppear:(BOOL)animated
{
    if(self.blurView.alpha==0.0)
        {
        [UIView animateWithDuration:0.4 animations:^{
                            [self.blurView setAlpha:1.0];
                        }];
        }
}
- (void) viewDidDisappear:(BOOL)animated
{
    self.blurView.alpha=0.0;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView * iv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TransportPlanes.jpg"]];
    [self.view addSubview:iv];
   
    self.blurView=[[UIToolbar alloc] initWithFrame:self.view.bounds];
    self.blurView.barStyle=UIBarStyleBlackTranslucent;
    self.blurView.alpha=0.0;
    self.blurView.hidden=NO;
    [self.view addSubview:self.blurView];
   [self.view sendSubviewToBack:self.blurView];
    [self.view sendSubviewToBack:iv];
    
    // Do any additional setup after loading the view from its nib.
    self.nameLabel.text=self.place.name;
    self.addressLabel.text=self.place.address;
    self.phoneLabel.text=self.place.phone;
    self.urlLabel.text=self.place.url;
    self.descriptionTextView.text=self.place.placeDescription;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)getDirections:(id)sender
{
    CLLocationCoordinate2D latLng;
    latLng.latitude=self.place.latitude;
    latLng.longitude = self.place.longitude;
    
    MKPlacemark* place = [[MKPlacemark alloc] initWithCoordinate: latLng addressDictionary: nil];
    MKMapItem* destination = [[MKMapItem alloc] initWithPlacemark: place];
    destination.name = self.place.name;
    
    NSArray* items = [[NSArray alloc] initWithObjects: destination, nil];
    NSDictionary* options = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 MKLaunchOptionsDirectionsModeDriving, 
                                 MKLaunchOptionsDirectionsModeKey, nil];
    [MKMapItem openMapsWithItems: items launchOptions: options];
}
@end
