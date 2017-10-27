//
//  UIGestureRecognizer+Find.m
//  FindGestureDemo
//
//  Created by fengche on 2017/10/27.
//  Copyright © 2017年 fengche. All rights reserved.
//

#import "UIGestureRecognizer+Find.h"
#import "MyGestureAddInfo.h"
#import <objc/runtime.h>


static void *_gestureAddInfo = &_gestureAddInfo;


@implementation UIGestureRecognizer (Find)

+ (void)load{
    Method oriMethod;
    Method swizzleMethod;
    
    //交换添加target sel的入口
    oriMethod = class_getInstanceMethod(self, @selector(initWithTarget:action:));
    swizzleMethod = class_getInstanceMethod(self, @selector(swizzleInitWithTarget:action:));
    method_exchangeImplementations(oriMethod, swizzleMethod);
    
    
    oriMethod = class_getInstanceMethod(self, @selector(addTarget:action:));
    swizzleMethod = class_getInstanceMethod(self, @selector(swizzleAddTarget:action:));
    method_exchangeImplementations(oriMethod, swizzleMethod);
    
    
}

- (instancetype)swizzleInitWithTarget:(nullable id)target action:(nullable SEL)action{
    MyGestureAddInfo *info = [MyGestureAddInfo new];
    info.heapInfos = [NSThread callStackSymbols];
    info.target = target;
    info.sel = action;
    [self setGestureAddInfo:info];
    
     return [self swizzleInitWithTarget:self action:@selector(swizzleGestureFunc:)];
}


- (void)swizzleAddTarget:(id)target action:(SEL)action{
    MyGestureAddInfo *info = [MyGestureAddInfo new];
    info.heapInfos = [NSThread callStackSymbols];
    info.target = target;
    info.sel = action;
    [self setGestureAddInfo:info];
    
    [self swizzleInitWithTarget:self action:@selector(swizzleGestureFunc:)];
}

#pragma mark - setter && getter
- (void)setGestureAddInfo:(id)guestureAddInfo{
      objc_setAssociatedObject(self, _gestureAddInfo, guestureAddInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
};


- (id)gestureAddInfo{
    return  objc_getAssociatedObject(self, _gestureAddInfo);
};


#pragma mark -
- (void)swizzleGestureFunc:(UIGestureRecognizer*)ges{
    
    MyGestureAddInfo *info =  [self gestureAddInfo];
    NSLog(@"GestureAddInfo:\n%@\n" , info.heapInfos);

    if ([info.target respondsToSelector:info.sel]) {
        [info.target performSelector:info.sel withObject:self];
    }

}




@end
