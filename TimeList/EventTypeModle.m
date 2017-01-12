//
//  EventTypeModle.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/12.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "EventTypeModle.h"
#import "Constants.h"
#import "EventTypeModle+FMDB.h"


@interface EventTypeModle()

@property (nonatomic, readwrite, strong) UIColor *color;

@end

@implementation EventTypeModle

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

@end
