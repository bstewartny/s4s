//
//  SOSPlace.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/7/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSPlace.h"
#import "NSDictionary+NSDictionary_NSNullHandling.h"

@implementation SOSPlace

- (id) initFromJson:(NSDictionary*)json
{
    self=[self init];
    if(self)
    {
        self.name=[[json objectForKey:@"fields"] stringForKey:@"name"];
        self.placeDescription=[[json objectForKey:@"fields" ]stringForKey:@"description"];
        self.address=[[json objectForKey:@"fields" ]stringForKey:@"address"];
        self.phone=[[json objectForKey:@"fields" ]stringForKey:@"phone"];
        self.email=[[json objectForKey:@"fields" ]stringForKey:@"email"];
        self.url=[[json objectForKey:@"fields" ]stringForKey:@"url"];
        self.pin_url=[[json objectForKey:@"fields" ]stringForKey:@"pin_url"];
        self.image_url=[[json objectForKey:@"fields" ]stringForKey:@"image_url"];
        self.category=[[json objectForKey:@"fields" ]stringForKey:@"category"];
        self.veteran_discounts=[self boolValue:[[json objectForKey:@"fields"] objectForKey:@"veteran_discounts"]] ;
        self.veteran_owned=[self boolValue:[[json objectForKey:@"fields"] objectForKey:@"veteran_owned"]] ;
        self.disabled_veteran=[self boolValue:[[json objectForKey:@"fields"] objectForKey:@"disabled_veteran"]] ;
        self.points_per_checkin=[[[json objectForKey:@"fields"] objectForKey:@"points_per_checkin"] integerValue];
        self.latitude=[[[json objectForKey:@"fields"] objectForKey:@"lat"] doubleValue];
        self.longitude=[[[json objectForKey:@"fields"] objectForKey:@"lon"] doubleValue];
    }
    return self;
}

- (BOOL) boolValue:(id)obj
{
    if([obj isKindOfClass:[NSNull class]])
    {
        return NO;
    }
    else
        return [obj boolValue];
}


@end
