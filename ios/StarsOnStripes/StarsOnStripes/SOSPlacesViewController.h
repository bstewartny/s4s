//
//  SOSPlacesViewController.h
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/7/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SOSPlace.h"

@interface SOSPlacesViewController : UIViewController<MKMapViewDelegate,UISearchBarDelegate>

@property(nonatomic,strong) MKMapView * mapView;
@property(nonatomic,strong) NSArray * data;
@property(nonatomic,strong) UISearchBar * searchBar;
@end
