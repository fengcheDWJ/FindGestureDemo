//
//  ViewController.m
//  FindGestureDemo
//
//  Created by fengche on 2017/10/27.
//  Copyright © 2017年 fengche. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor greenColor];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
    [tap addTarget:self action:@selector(tap:)];
    
    [view addGestureRecognizer:tap];
}

- (void)tap:(id)tap{
    NSLog(@"tap");
}


@end
