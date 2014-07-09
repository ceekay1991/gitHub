//
//  WATestProgressBarViewController.h
//  ProgressControl
//
//  Created by crh on 14-7-9.
//  Copyright (c) 2014年 yonyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WAProgressView.h"
@interface WATestProgressBarViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet WAProgressView *progress;
- (IBAction)sliderchange:(id)sender;

@end
