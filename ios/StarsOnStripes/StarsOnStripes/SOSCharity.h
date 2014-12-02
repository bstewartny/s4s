//
//  SOSCharity.h
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/8/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOSCharity : NSObject

@property(nonatomic,strong) NSString * name;
@property(nonatomic,strong) NSString * charityDescription;
@property(nonatomic,strong) NSString * link;
@property(nonatomic,strong) NSString * image_link;
@property(nonatomic) NSInteger donated_points;

- (id) initFromJson:(NSDictionary*)json;

@end
