//
//  SOSJob.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/8/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSJob.h"

@implementation SOSJob

- (id) initFromJson:(NSDictionary*)json
{
    self=[self init];
    if(self)
    {
        self.title=[[json objectForKey:@"fields"] objectForKey:@"title"];
        self.jobDescription=[[json objectForKey:@"fields" ]objectForKey:@"description"];
        self.category=[[json objectForKey:@"fields" ]objectForKey:@"category"];
        self.contact_link=[[json objectForKey:@"fields" ]objectForKey:@"contact_link"];
        self.contact_email=[[json objectForKey:@"fields" ]objectForKey:@"contact_email"];
        self.contact_phone=[[json objectForKey:@"fields" ]objectForKey:@"contact_phone"];
        self.reference_code=[[json objectForKey:@"fields" ]objectForKey:@"reference_code"];
        self.business=nil;
    }
    return self;
}
@end
