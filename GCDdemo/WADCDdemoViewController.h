//
//  WADCDdemoViewController.h
//  GCDdemo
//
//  Created by crh on 14-7-8.
//  Copyright (c) 2014年 yonyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WADCDdemoViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *gcdimage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadview;

- (IBAction)downImageAction:(id)sender;
- (IBAction)touchUpInsideBySeialThreadOne:(id)sender;
- (IBAction)touchUpInsideByGloableThreadOne:(id)sender;
- (IBAction)touchUpInsideByGroupThreadOne:(id)sender;
@end
