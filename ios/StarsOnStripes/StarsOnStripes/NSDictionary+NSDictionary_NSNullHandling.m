//
//  NSDictionary+NSDictionary_NSNullHandling.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/9/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "NSDictionary+NSDictionary_NSNullHandling.h"

@implementation NSDictionary (NSDictionary_NSNullHandling)

- (NSString*) stringForKey:(id)aKey
{
    id obj=[self objectForKey:aKey];
    
    if([obj isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    else
    {
        if([obj isKindOfClass:[NSString class]])
        {
            return obj;
        }
        else{
            return [obj stringValue];
        }
    }
}
@end
