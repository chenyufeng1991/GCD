//
//  ViewController.m
//  GCD06
//
//  Created by chenyufeng on 15/10/22.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "ViewController.h"
#import "GCD.h"

@interface ViewController ()

@property(strong,nonatomic) UIImageView *view1;
@property(strong,nonatomic) UIImageView *view2;
@property(strong,nonatomic) UIImageView *view3;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSLog(@"%@",NSHomeDirectory());
  
  self.view1 = [self setImageViewFrame:CGRectMake(0, 0, 300, 200)];
  self.view2 = [self setImageViewFrame:CGRectMake(0, 200, 300, 200)];
  self.view3 = [self setImageViewFrame:CGRectMake(0, 400, 300, 200)];
  
  NSString *url01 = @"http://pic17.nipic.com/20111026/8662498_125925242183_2.jpg";
  NSString *url02 = @"http://b.hiphotos.baidu.com/zhidao/wh%3D  450%2C600/sign=53da5874352ac65c67506e77cec29e27/9f2f070828381f30807909bda9014c086e06f046.jpg";
  NSString *url03 = @"http://cimg.163.com/sport/0412/23/wu2305.jpg";
  
  
  GCDSemaphore *semaphore = [[GCDSemaphore alloc] init];
  GCDSemaphore *semaphore2 = [[GCDSemaphore alloc] init];
  
  //开启三个异步线程；
  
  [GCDQueue executeInGlobalQueue:^{
    
    UIImage *image01 = [self accessDataByNetwork:url01];
    
    [GCDQueue executeInMainQueue:^{
      
      [UIView animateWithDuration:2.0f
                       animations:^{
                         self.view1.image = image01;
                         [self.view1 setAlpha:1.0f];
                         
                       } completion:^(BOOL finished) {
                         
                         //通知第1个信号量；
                         [semaphore signal];
                       }];
      
    }];
    
  }];
  
  
  [GCDQueue executeInGlobalQueue:^{
    
    UIImage *image02 = [self accessDataByNetwork:url02];
    
    //第1个信号量等待；
    [semaphore wait];
    
    [GCDQueue executeInMainQueue:^{
      
      [UIView animateWithDuration:2.0f
                       animations:^{
                         self.view2.image = image02;
                         [self.view2 setAlpha:1.0f];
                         
                       } completion:^(BOOL finished) {
                         
                         //通知第2个信号量；
                         [semaphore2 signal];
                       }];
      
    }];
    
  }];
  
  
  
  [GCDQueue executeInGlobalQueue:^{
    
    UIImage *image03 = [self accessDataByNetwork:url03];
    
    //第2个信号量等待；
    [semaphore2 wait];
    
    [GCDQueue executeInMainQueue:^{
      
      [UIView animateWithDuration:2.0f
                       animations:^{
                         self.view3.image = image03;
                         [self.view3 setAlpha:1.0f];
                         
                       } completion:^(BOOL finished) {
                         
                       }];
      
    }];
    
  }];
  
}


//设置图片大小位置和透明度；alpha = 0表示完全透明；
- (UIImageView *)setImageViewFrame:(CGRect)frame{
  
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
  imageView.alpha = 0.f;
  [self.view addSubview:imageView];
  
  return imageView;
  
}


//进行网络请求；
- (UIImage *)accessDataByNetwork:(NSString *)string{
  
  
  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:string]];
  NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
  
  return [UIImage imageWithData:data];
  
}






@end















