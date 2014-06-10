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

- (NSString*) imageNameForPin
{
    NSString * category=self.place.category;
    if([category length]==0)
    {
        return @"townhouse.png";
    }
    if([category integerValue]==1)
    {
        return @"statue-2.png";
    }
    
    if([category integerValue]==2)
    {
        return @"museum_war.png";
    }
    if(self.place.disabled_veteran)
    {
        return @"purple-army.png";
    }
    
    if(self.place.veteran_owned && self.place.veteran_discounts)
    {
        return @"army.png";
    }
    
    if(self.place.veteran_owned)
    {
    
        return @"army.png";
    }
    
    if(self.place.veteran_discounts)
    {
    
        return @"star-3.png";
    }
    return @"townhouse.png";
}
@end
