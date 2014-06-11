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
#import "SOSPlaceViewController.h"
#import "ProgressHUD.h"

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


    UIBarButtonItem * refreshButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    
    self.navigationItem.leftBarButtonItem = refreshButton;


    UIBarButtonItem * searchButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search:)];
    
    self.navigationItem.rightBarButtonItem = searchButton;
    
    [self.view addSubview:self.mapView];
    
    CLLocationCoordinate2D startCoord = [((SOSAppDelegate*)[[UIApplication sharedApplication] delegate]) currentCoordinate];
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 2500, 2500)];
    [self.mapView setRegion:adjustedRegion animated:YES];
    
    [self getData];
    
}

- (void)refresh:(id)sender
{
    [((SOSAppDelegate*)[[UIApplication sharedApplication] delegate]) showLoginForm];
    //[self clearPlaces];
    //CLLocationCoordinate2D startCoord = [((SOSAppDelegate*)[[UIApplication sharedApplication] delegate]) currentCoordinate];
    //MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 2500, 2500)];
    //[self.mapView setRegion:adjustedRegion animated:YES];
    //[self getData];
}

- (void)search:(id)sender
{
    if(self.searchBar==nil)
    {
        [self clearPlaces];
        self.searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, 320.0, 38.0)];
        self.searchBar.delegate=self;
        self.searchBar.showsCancelButton=YES;
        [self.searchBar sizeToFit];
        [self.view addSubview:self.searchBar];
        [self.searchBar becomeFirstResponder];
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self clearPlaces];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"searchText: %@",searchText);
    [self clearPlaces];
    [self renderPlaces:[self.data filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name contains[cd] %@",searchText]]];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self clearPlaces];
    [self.searchBar resignFirstResponder];
    [self renderPlaces:[self.data filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name contains[cd] %@",searchBar.text]]];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [self.searchBar resignFirstResponder];
    [self.searchBar removeFromSuperview];
    self.searchBar=nil;
    [self renderPlaces:self.data];
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
    [ProgressHUD show:@"Loading..."];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        dispatch_async(dispatch_get_main_queue(), ^{
            [ProgressHUD dismiss];
        });
        if (error) {
            NSLog(@"error: %@",[error description]);
            dispatch_async(dispatch_get_main_queue(), ^{
                [ProgressHUD showError:[error description]];
            });
        } else {
            NSError * jsonError=NULL;
            self.data=[self parseJsonResults:data error:&jsonError];
            if(error)
            {
                NSLog(@"json error: %@",[jsonError description]);
                dispatch_async(dispatch_get_main_queue(), ^{
                [ProgressHUD showError:[jsonError description]];
            });
            }
            else{
                NSLog(@"Got %d results",[self.data count]);
                NSLog(@"calling reloadData");
                dispatch_async(dispatch_get_main_queue(), ^{
                    // do work here
                    [self renderPlaces:self.data];
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
    [self.mapView removeAnnotations:self.mapView.annotations];
    CLLocationCoordinate2D startCoord = [((SOSAppDelegate*)[[UIApplication sharedApplication] delegate]) currentCoordinate];
            MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 2500, 2500)];
            [self.mapView setRegion:adjustedRegion animated:NO];
}

- (void) renderPlaces:(NSArray*)places
{
    NSLog(@"renderPlaces: %d",[places count]);
        for(SOSPlace * place in places)
        {
            [self renderPlace:place];
        }
    
        if([places count]<5 && [places count]>0)
        {
            // zoom map appropriately
            MKMapRect zoomRect = MKMapRectNull;
            for (id <MKAnnotation> annotation in self.mapView.annotations) {
                MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
                MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
                if (MKMapRectIsNull(zoomRect)) {
                    zoomRect = pointRect;
                } else {
                    zoomRect = MKMapRectUnion(zoomRect, pointRect);
                }
            }
            //[self.mapView setVisibleMapRect:zoomRect animated:YES];
            [self.mapView setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsMake(10, 10, 10, 10) animated:YES];
            
            if([places count]==1)
            {
                // show annotation view for that place...
                if([[self.mapView selectedAnnotations] count]==0)
                {
                    [self.mapView selectAnnotation:[self.mapView.annotations objectAtIndex:0] animated:YES];
                }
            }
        }
        else
        {
            CLLocationCoordinate2D startCoord = [((SOSAppDelegate*)[[UIApplication sharedApplication] delegate]) currentCoordinate];
            MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 2500, 2500)];
            [self.mapView setRegion:adjustedRegion animated:YES];
        }
}


- (void) renderPlace:(SOSPlace*)place
{

    [self.mapView addAnnotation:[[SOSPlaceAnnotation alloc] initWithPlace:place]];
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    annotationView.image=[UIImage imageNamed:[((SOSPlaceAnnotation*)annotation) imageNameForPin]];
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
    SOSPlace * place=((SOSPlaceAnnotation*)view.annotation).place;
    
    NSLog(@"place: %@",place.name);
    SOSPlaceViewController * placeView=[[SOSPlaceViewController alloc] initWithPlace:place];
    
    [self.navigationController  pushViewController:placeView animated:YES];
}
    


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
