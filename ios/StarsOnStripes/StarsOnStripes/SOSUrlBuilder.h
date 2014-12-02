//
//  SOSUrlBuilder.h
//  StarsOnStripes
//
//  Created by Robert Stewart on 12/2/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOSUrlBuilder : NSObject

+ (NSURL*) buildUrlWithCommand:(NSString*)command;

@end
