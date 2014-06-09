//
//  SOSPlace.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/7/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSPlace.h"

@implementation SOSPlace

- (id) initFromJson:(NSDictionary*)json
{
    self=[self init];
    if(self)
    {
        self.name=[[json objectForKey:@"fields"] objectForKey:@"name"];
        self.description=[[json objectForKey:@"fields" ]objectForKey:@"description"];
        self.address=[[json objectForKey:@"fields" ]objectForKey:@"address"];
        self.phone=[[json objectForKey:@"fields" ]objectForKey:@"phone"];
        self.email=[[json objectForKey:@"fields" ]objectForKey:@"email"];
        self.url=[[json objectForKey:@"fields" ]objectForKey:@"url"];
        self.pin_url=[[json objectForKey:@"fields" ]objectForKey:@"pin_url"];
        self.image_url=[[json objectForKey:@"fields" ]objectForKey:@"image_url"];
        self.category=[[json objectForKey:@"fields" ]objectForKey:@"category"];
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
