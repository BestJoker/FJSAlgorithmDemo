//
//  FJSDefaultManager.m
//  AlgorithmDemo
//
//  Created by 付金诗 on 16/6/22.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import "FJSDefaultManager.h"

@implementation FJSDefaultManager
+ (FJSDefaultManager *)defaultManager
{
    static FJSDefaultManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FJSDefaultManager alloc] init];
    });
    return manager;
}

+ (NSString *)qucikSortWithDataArray:(NSMutableArray *)dataArray
{
    
    return @"三打三防";
}









@end
