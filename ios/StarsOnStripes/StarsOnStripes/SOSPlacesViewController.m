//
//  SOSPlacesViewController.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/7/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSPlacesViewController.h"

@interface SOSPlacesViewController ()

@end

@implementation SOSPlacesViewController

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
	// Do any additional setup after loading the view.
    self.mapView=[[MKMapView alloc] initWithFrame:self.view.frame];

    [self.view addSubview:self.mapView];
    
}

- (void) clearPlaces
{

}

- (void) renderPlaces:(NSArray*)places
{
        for(SOSPlace * place in places)
        {
            [self renderPlace:place];
        }
}

- (void) renderPlace:(SOSPlace*)place
{
    [self.mapView addAnnotation:place];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
