//
//  CustomClass.m
//  ObjcDictKeyTest
//
//  Created by 缪 和光 on 12-10-11.
//  Copyright (c) 2012年 缪 和光. All rights reserved.
//

#import "CustomClass.h"
@interface CustomClass()

@property (unsafe_unretained) NSUInteger myHash;

@end

@implementation CustomClass

- (id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc]init];
    if (copy) {
        [copy setName:[self.name copyWithZone:zone]];
        [copy setMyHash:self.myHash];
    }
    return copy;
}
- (id)init
{
    if (self = [super init]) {
        _myHash = (NSUInteger)self;
    }
    return self;
}
- (NSUInteger)hash
{
    return _myHash;
}
- (BOOL)isEqual:(id)object
{
    return self.myHash == ((CustomClass *)object).myHash;
}
@end
