//
//  ViewController.m
//  GCD05
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

  
//  //创建信号量
  GCDSemaphore *semaphore = [[GCDSemaphore alloc] init];
  
  
  //线程1； - 异步
  //无法确定这两个线程哪个先执行，因为是异步线程。
  [GCDQueue executeInGlobalQueue:^{

    NSLog(@"线程1");
    
    //发送信号量；
    [semaphore signal];
    
  }];
  
  //线程1； - 异步
  [GCDQueue executeInGlobalQueue:^{
    
    //等待信号；
    [semaphore wait];
    
    NSLog(@"线程2");
    
  }];
  
}

@end
