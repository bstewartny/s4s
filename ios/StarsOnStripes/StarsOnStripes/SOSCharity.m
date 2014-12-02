//
//  SOSCharity.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/8/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSCharity.h"

@implementation SOSCharity

- (id) initFromJson:(NSDictionary*)json
{
    self=[self init];
    if(self)
    {
        self.name=[[json objectForKey:@"fields"] objectForKey:@"name"];
        self.charityDescription=[[json objectForKey:@"fields" ]objectForKey:@"description"];
        self.link=[[json objectForKey:@"fields" ]objectForKey:@"link"];
        self.image_link=[[json objectForKey:@"fields" ]objectForKey:@"image_link"];
        self.donated_points=[[[json objectForKey:@"fields" ]objectForKey:@"donated_points"] integerValue];
    }
    return self;
}

@end
