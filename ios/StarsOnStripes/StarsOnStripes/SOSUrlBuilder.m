//
//  SOSUrlBuilder.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 12/2/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSUrlBuilder.h"

@implementation SOSUrlBuilder


+ (NSURL*) buildUrlWithCommand:(NSString*)command
{
    NSString *urlAsString = [NSString stringWithFormat:@"http://ec2-54-242-0-147.compute-1.amazonaws.com/vetbiz/api/%@",command];
    NSLog(@"url: %@",urlAsString);

    return [[NSURL alloc] initWithString:urlAsString];
}
@end
