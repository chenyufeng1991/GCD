//
//  ViewController.m
//  GCD02
//
//  Created by chenyufeng on 15/10/22.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "ViewController.h"
#import "GCD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {

  [super viewDidLoad];
  NSLog(@"开始启动");
  //NSThread方式的延时执行操作；
  [self performSelector:@selector(threadEvent:)
             withObject:self
             afterDelay:2.f];
  //NSThread可以取消延时操作；
//  [NSObject cancelPreviousPerformRequestsWithTarget:self];
  //GCD方式实现延迟；
  //主线程；
  [GCDQueue executeInMainQueue:^{
    NSLog(@"GCD实现延迟操作");
  } afterDelaySecs:2.f];
}

- (void)threadEvent:(id)sender{
  NSLog(@"NSThread实现延时操作");
}

@end
