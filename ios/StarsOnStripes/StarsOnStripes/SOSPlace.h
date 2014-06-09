//
//  SOSPlace.h
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/7/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOSPlace : NSObject


@property(nonatomic) double latitude;
@property(nonatomic) double longitude;

@property(nonatomic,strong) NSString * category;
@property(nonatomic,strong) NSString * description;
@property(nonatomic,strong) NSString * address;
@property(nonatomic,strong) NSString * phone;
@property(nonatomic,strong) NSString * email;
@property(nonatomic,strong) NSString * url;
@property(nonatomic,strong) NSString * image_url;
@property(nonatomic,strong) NSString * pin_url;
@property(nonatomic,strong) NSString * name;
@property(nonatomic) BOOL veteran_discounts;
@property(nonatomic) BOOL veteran_owned;
@property(nonatomic) BOOL disabled_veteran;
@property(nonatomic) NSInteger points_per_checkin;

- (id) initFromJson:(NSDictionary*)json;

@end
