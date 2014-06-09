//
//  SOSPlaceAnnotation.h
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/9/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>
#import <MapKit/MKAnnotation.h>
#import "SOSPlace.h"

@interface SOSPlaceAnnotation : NSObject<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

// Title and subtitle for use by selection UI.
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;
- (id) initWithPlace:(SOSPlace*)place;


@end
