//
//  EventTypeModle.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/12.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "EventTypeModel.h"
#import "Constants.h"
#import "EventTypeModel+FMDB.h"


@interface EventTypeModel()

@property (nonatomic, readwrite, strong) UIColor *color;

@end

@implementation EventTypeModel

- (instancetype)init
{
    self = [super init];
    if ( !self ){
        return nil;
    }
    _isDefault = NO;
    _identifier = @"";
    _color = [UIColor grayColor];
    _title = @"";
    return self;
}

- (instancetype)initWithIdentifier:(NSString *)identifier title:(NSString *)title isDefault:(BOOL)isDefault
{
    self = [self init];
    if ( !self ){
        return nil;
    }
    _identifier = identifier;
    _title = title;
    _isDefault = isDefault;
    _color = [UIColor colorWithHexString:identifier?:@"#000000"];

    return self;
}

- (void)setIdentifier:(NSString *)identifier
{
    _identifier = identifier;
    _color = [UIColor colorWithHexString:identifier?:@"#000000"];
}

- (BOOL)dataIntegrity
{
    if ( !_identifier || _identifier.length <= 0 || !_title || _title.length <= 0  ){
        return NO;
    }
    return YES;
}
@end
