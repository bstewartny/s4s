//
//  SOSOffer.h
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/8/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOSPlace.h"

@interface SOSOffer : NSObject

@property(nonatomic,strong) NSString * title;
@property(nonatomic,strong) NSString * offerDescription;
@property(nonatomic,strong) SOSPlace * business;


- (id) initFromJson:(NSDictionary*)json;

@end
