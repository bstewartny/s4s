//
//  SOSOffer.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/8/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSOffer.h"
#import "NSDictionary+NSDictionary_NSNullHandling.h"

@implementation SOSOffer

- (id) initFromJson:(NSDictionary*)json
{
    self=[self init];
    if(self)
    {
        self.title=[[json objectForKey:@"fields"] stringForKey:@"title"];
        self.offerDescription=[[json objectForKey:@"fields" ]stringForKey:@"description"];
    }
    return self;
}

@end
