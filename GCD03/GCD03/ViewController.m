//
//  ViewController.m
//  GCD03
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
  //初始化线程组；
  GCDGroup *group = [[GCDGroup alloc] init];
  //创建一个线程队列；
  GCDQueue *queue = [[GCDQueue alloc] initConcurrent];
  //让线程在group中执行；(线程1)
  [queue execute:^{

    sleep(1);//延迟1s；
    NSLog(@"线程1执行完毕");
  } inGroup:group];
  //让线程在group中执行；（线程2）
  [queue execute:^{

    sleep(3);//延迟3s；
    NSLog(@"线程2执行完毕");
  } inGroup:group];
  
  //监听线程组是否执行结束，然后执行线程3；
  [queue notify:^{
    NSLog(@"线程3执行完毕");
  } inGroup:group];
}

@end
