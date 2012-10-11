//
//  main.m
//  ObjcDictKeyTest
//
//  Created by 缪 和光 on 12-10-11.
//  Copyright (c) 2012年 缪 和光. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomClass.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        CustomClass *a = [[CustomClass alloc]init];
        CustomClass *b = [[CustomClass alloc]init];
        a.name = @"a";
        b.name = @"a";
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@"aaa" forKey:a];
        [dict setObject:@"bbb" forKey:b];
        NSLog(@"%@",[dict objectForKey:b]);
        NSLog(@"dict count: %ld",dict.count);
    }
    return 0;
}

