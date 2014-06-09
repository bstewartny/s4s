//
//  SOSJob.h
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/8/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOSPlace.h"

@interface SOSJob : NSObject

@property(nonatomic,strong) NSString * category;
@property(nonatomic,strong) NSString * description;
@property(nonatomic,strong) NSString * title;
@property(nonatomic,strong) NSString * phone;
@property(nonatomic,strong) NSString * contact_link;
@property(nonatomic,strong) NSString * contact_email;
@property(nonatomic,strong) NSString * contact_phone;
@property(nonatomic,strong) NSString * reference_code;
@property(nonatomic,strong) SOSPlace * business;

- (id) initFromJson:(NSDictionary*)json;

@end
