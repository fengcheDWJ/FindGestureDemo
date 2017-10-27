//
//  MyGestureAddInfo.h
//  FindGestureDemo
//
//  Created by fengche on 2017/10/27.
//  Copyright © 2017年 fengche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyGestureAddInfo : NSObject

@property (nonatomic , copy) NSArray *heapInfos;
@property (nonatomic , weak) id target;
@property (nonatomic , unsafe_unretained) SEL sel;

@end
