//
//  ViewController.m
//  GCD01
//
//  Created by chenyufeng on 15/10/22.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "ViewController.h"
#import "GCD.h"

@interface ViewController ()

@property(strong,nonatomic) UIImage *image;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {

  [super viewDidLoad];
  //执行串行队列；
//  [self serailQueue];
  
  //执行并发队列；
//  [self concurrent];

  [GCDQueue executeInGlobalQueue:^{
    
    //处理业务逻辑
    NSString *url = @"http://imgsrc.baidu.com/forum/w%3D580/sign=2e824145d2c8a786be2a4a065708c9c7/5a8e72094b36acaf254077437fd98d1000e99c4a.jpg";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *picData = [NSURLConnection sendSynchronousRequest:request
                                            returningResponse:nil
                                                        error:nil];
    NSLog(@"处理业务逻辑");
    //获取图片；
    self.image = [UIImage imageWithData:picData];
    [GCDQueue executeInMainQueue:^{
      
      NSLog(@"更新UI");
      //更新UI
      [self.imageView setImage:self.image];
    }];
  }];
}
//并发队列；
//- (void)concurrent{
//  //创建出队列；
//  GCDQueue *queue = [[GCDQueue alloc] initConcurrent];
//  
//  //执行队列中的线程；
//  [queue execute:^{
//    
//    NSLog(@"1");
//    
//  }];
//  
//  
//  [queue execute:^{
//    
//    NSLog(@"2");
//    
//  }];
//  
//  
//  [queue execute:^{
//    
//    NSLog(@"3");
//    
//  }];
//  
//  
//  [queue execute:^{
//    
//    NSLog(@"4");
//    
//  }];
//  
//  
//  [queue execute:^{
//    
//    NSLog(@"5");
//    
//  }];
//  
//}



//串行队列；
//- (void)serailQueue{
//
//  //创建出队列；
//  GCDQueue *queue = [[GCDQueue alloc] initSerial];
//  
//  //执行队列中的线程；
//  [queue execute:^{
//    
//    NSLog(@"1");
//    
//  }];
//  
//  
//  [queue execute:^{
//    
//    NSLog(@"2");
//    
//  }];
//  
//  
//  [queue execute:^{
//    
//    NSLog(@"3");
//    
//  }];
//  
//  
//  [queue execute:^{
//    
//    NSLog(@"4");
//    
//  }];
//  
//  
//  [queue execute:^{
//    
//    NSLog(@"5");
//    
//  }];
//  
//}

@end
