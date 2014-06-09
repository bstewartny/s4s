//
//  SOSPlacesViewController.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/7/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSPlacesViewController.h"
#import "SOSPlace.h"
#import <CoreLocation/CLLocation.h>
#import <MapKit/MKAnnotation.h>
#import "SOSAppDelegate.h"
#import "SOSPlaceAnnotation.h"

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

    self.mapView.delegate=self;

    [self.view addSubview:self.mapView];
    
    CLLocationCoordinate2D startCoord = [((SOSAppDelegate*)[[UIApplication sharedApplication] delegate]) currentCoordinate];
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 2500, 2500)];
    [self.mapView setRegion:adjustedRegion animated:YES];
    
    [self getData];
    
}

- (NSString*) dataUrl
{
    CLLocationCoordinate2D coordinate=[((SOSAppDelegate*)[[UIApplication sharedApplication] delegate]) currentCoordinate];
    NSString *urlAsString = [NSString stringWithFormat:@"http://www.starsonstripes.com/vetbiz/api/places/?lat=%f&lon=%f&radius=%d", coordinate.latitude, coordinate.longitude, 50000000];
    NSLog(@"url: %@",urlAsString);
    return urlAsString;
}

- (void) getData
{
    NSURL *url = [[NSURL alloc] initWithString:[self dataUrl]];
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            NSLog(@"error: %@",[error description]);
        } else {
            NSError * jsonError=NULL;
            self.data=[self parseJsonResults:data error:&jsonError];
            if(error)
            {
                NSLog(@"json error: %@",[jsonError description]);
            }
            else{
                NSLog(@"Got %d results",[self.data count]);
                NSLog(@"calling reloadData");
                dispatch_async(dispatch_get_main_queue(), ^{
                    // do work here
                    [self renderPlaces];
                });
            }
        }
    }];
}
- (id) objectFromJson:(NSDictionary *)json
{
    SOSPlace * place=[[SOSPlace alloc] initFromJson:json];
    return place;
}
- (NSArray*) parseJsonResults:(NSData*)data error:(NSError**)error
{
    NSError *localError = nil;
    
    NSArray *results = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray * objects=[[NSMutableArray alloc] init];
    
    for(NSDictionary * json in results)
    {
        [objects addObject:[self objectFromJson:json]];
    }
    return objects;
}

- (void) clearPlaces
{

}

- (void) renderPlaces
{
        for(SOSPlace * place in self.data)
        {
            [self renderPlace:place];
        }
}


- (void) renderPlace:(SOSPlace*)place
{

    [self.mapView addAnnotation:[[SOSPlaceAnnotation alloc] initWithPlace:place]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
