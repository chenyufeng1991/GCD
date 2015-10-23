//
//  ViewController.m
//  GCD04
//
//  Created by chenyufeng on 15/10/22.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "ViewController.h"
#import "GCD.h"

@interface ViewController ()

@property(strong,nonatomic) GCDTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  
  //运行GCDTimer
  [self runGCDTimer];
  
}

- (void)runGCDTimer{

  //初始化定时器
  self.timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
  
  //指定时间间隔以及要执行的事件；
  [self.timer event:^{
    
    //在这里写入需要重复执行的代码；
    NSLog(@"GCD定时器");
  } timeIntervalWithSecs:1.f];
  
  //运行
  [self.timer start];
}



@end
