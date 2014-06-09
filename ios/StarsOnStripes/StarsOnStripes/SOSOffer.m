//
//  SOSOffer.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/8/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSOffer.h"

@implementation SOSOffer

- (id) initFromJson:(NSDictionary*)json
{
    self=[self init];
    if(self)
    {
        self.title=[[json objectForKey:@"fields"] objectForKey:@"title"];
        self.description=[[json objectForKey:@"fields" ]objectForKey:@"description"];
        //self.business=[[json objectForKey:@"fields"] objectForKey:@"business"];
        
    }
    return self;
}

@end
