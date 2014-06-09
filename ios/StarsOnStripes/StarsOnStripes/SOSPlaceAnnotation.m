//
//  SOSPlaceAnnotation.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/9/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSPlaceAnnotation.h"
#import "SOSPlace.h"

@implementation SOSPlaceAnnotation


- (id) initWithPlace:(SOSPlace*)place
{
    self=[self init];
    if(self)
    {
        _title=place.name;
        _subtitle=place.address;
        _coordinate.longitude=place.longitude;
        _coordinate.latitude =place.latitude;
        self.place=place;
    }
    return self;

}
@end
