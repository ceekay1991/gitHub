//
//  WADCDdemoViewController.m
//  GCDdemo
//
//  Created by crh on 14-7-8.
//  Copyright (c) 2014年 yonyou. All rights reserved.
//

#import "WADCDdemoViewController.h"

@interface WADCDdemoViewController ()

@end

@implementation WADCDdemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  self.loadview.hidden = YES; 
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)downImageAction:(id)sender
{
  self.loadview.hidden = NO ;
  [self.loadview startAnimating];
  dispatch_queue_t downloadquee = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_async(downloadquee, ^{
    NSString *url = @"http://g.hiphotos.baidu.com/image/w%3D230/sign=fd8c71d534d12f2ece05a9637fc3d5ff/6d81800a19d8bc3e375516c8808ba61ea8d34556.jpg";
    NSURL *downLoadUrl = [NSURL URLWithString:url];
    NSData *imgdata = [NSData dataWithContentsOfURL:downLoadUrl];
    UIImage  *img = [UIImage imageWithData:imgdata];
    if (img)
    {
      
      dispatch_sync(dispatch_get_main_queue(), ^{
        [self.loadview stopAnimating];
        self.loadview.hidden = YES ;
        self.gcdimage.image = img;
      });
    }
  });
}

- (IBAction)touchUpInsideBySeialThreadOne:(id)sender {
  NSDate *da = [NSDate date];
  NSString *daStr = [da description];
  const char *queueName = [daStr UTF8String];
  dispatch_queue_t myQueue = dispatch_queue_create(queueName, DISPATCH_QUEUE_SERIAL);
  
  dispatch_async(myQueue, ^{
    NSLog(@"加入顺序---%@--1",[NSThread currentThread].name);
    [NSThread sleepForTimeInterval:6];
    NSLog(@"[NSThread sleepForTimeInterval:6];");
  });
  
  dispatch_async(myQueue, ^{
    NSLog(@"加入顺序---%@--2",[NSThread currentThread].name);
    [NSThread sleepForTimeInterval:3];
    NSLog(@"[NSThread sleepForTimeInterval:3];");
  });
  
  dispatch_async(myQueue, ^{
    NSLog(@"加入顺序---%@--3",[NSThread currentThread].name);
    [NSThread sleepForTimeInterval:1];
    NSLog(@"[NSThread sleepForTimeInterval:1];");
  });
  

}

//多线程
- (IBAction)touchUpInsideByGloableThreadOne:(id)sender
{
  dispatch_queue_t myQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  
  dispatch_async(myQueue, ^{
    NSLog(@"加入顺序---%@--1",[NSThread currentThread].name);
    [NSThread sleepForTimeInterval:6];
    NSLog(@"[NSThread sleepForTimeInterval:6];");
  });
  
  dispatch_async(myQueue, ^{
    NSLog(@"加入顺序---%@--2",[NSThread currentThread].name);
    [NSThread sleepForTimeInterval:3];
    NSLog(@"[NSThread sleepForTimeInterval:3];");
  });
  
  dispatch_async(myQueue, ^{
    NSLog(@"加入顺序---%@--3",[NSThread currentThread].name);
    [NSThread sleepForTimeInterval:1];
    NSLog(@"[NSThread sleepForTimeInterval:1];");
  });
  

}
- (IBAction)touchUpInsideByGroupThreadOne:(id)sender
{
  dispatch_queue_t groupque = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_group_t  group = dispatch_group_create();
  dispatch_group_async(group, groupque, ^{
    NSLog(@"加入顺序---%@--1",[NSThread currentThread].name);
    [NSThread sleepForTimeInterval:6];
    NSLog(@"[NSThread sleepForTimeInterval:6];");
  });
  dispatch_group_async(group, groupque, ^{
    NSLog(@"加入顺序---%@--2",[NSThread currentThread].name);
    [NSThread sleepForTimeInterval:3];
    NSLog(@"[NSThread sleepForTimeInterval:3];");
  });
  dispatch_group_async(group, groupque, ^{
    NSLog(@"加入顺序---%@--3",[NSThread currentThread].name);
    [NSThread sleepForTimeInterval:1];
    NSLog(@"[NSThread sleepForTimeInterval:1];");
  });
  dispatch_group_notify(group, dispatch_get_main_queue(), ^{
    NSLog(@"所有的任务已经处理完了");
  });
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  return YES;
}
@end
