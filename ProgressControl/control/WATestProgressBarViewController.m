//
//  WATestProgressBarViewController.m
//  ProgressControl
//
//  Created by crh on 14-7-9.
//  Copyright (c) 2014年 yonyou. All rights reserved.
//

#import "WATestProgressBarViewController.h"

@interface WATestProgressBarViewController ()

@end

@implementation WATestProgressBarViewController

- (id)init
{
  self = [super initWithNibName:@"WATestProgressBarViewController" bundle:nil];
    
  return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  // Update the sliders and switches according to the progress view
  self.slider.value = self.progress.progress;
  self.progress.maxProgress = 200;
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderchange:(id)sender
{
  self.progress.progress = self.slider.value;
//  0%  ~ 33%  ： 红色
//  33% ~ 67%  ： 黄色
//  67% ~ 100% ： 绿色
  [self.progress setFillColorWithFromProgress:0 andToProgress:33 andFillColor:[UIColor redColor]];
  [self.progress setFillColorWithFromProgress:33 andToProgress:67 andFillColor:[UIColor yellowColor]];
  [self.progress setFillColorWithFromProgress:67 andToProgress:100 andFillColor:[UIColor greenColor]];
  
}
@end
