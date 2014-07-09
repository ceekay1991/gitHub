//
//  WAProgressView.m
//  ProgressControl
//
//  Created by crh on 14-7-9.
//  Copyright (c) 2014年 yonyou. All rights reserved.
//

#import "WAProgressView.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
@implementation WAProgressView

+ (void)initialize
{
  if (self == [WAProgressView class])
  {
    id appearance = [self appearance];
    [appearance setThicknessRatio:0.37f];
    [appearance setInnerBackgroundColor:[UIColor grayColor]];
    [appearance setOuterBackgroundColor:[UIColor purpleColor]];
    [appearance setTextColor:[UIColor blackColor]];
    [appearance setFont:[UIFont systemFontOfSize:10]];
    [appearance setProgressFillColor:nil];
    // TODO: It's not guaranteed that UIView supports UIAppearance for backgroundColor.
    [appearance setBackgroundColor:[UIColor clearColor]];
  }
}
-(void)setAttrWithThicknessRatio:(CGFloat)thicknessRatio
                 andInberBgColor:(UIColor *)innerBgColor
                   andOutBgColor:(UIColor *)outBgColor
                    andTextColor:(UIColor *)textColor
                         andFont:(UIFont *)aFount
            andProgressFillColor:(UIColor *)fillColor
{
  self.thicknessRatio = thicknessRatio>0?thicknessRatio:0.37;
  self.innerBackgroundColor = innerBgColor?innerBgColor:[UIColor grayColor];
  self.outerBackgroundColor = outBgColor?outBgColor:[UIColor purpleColor];
  self.textColor = textColor?textColor:[UIColor blackColor];
  self.font = aFount?aFount:[UIFont systemFontOfSize:10];
  self.progressFillColor = fillColor?fillColor:nil;
  [self setNeedsDisplay];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
  // Calculate position of the circle
  CGFloat progressAngle = _progress * 360.0 - 90;
  CGPoint center = CGPointMake(rect.size.width / 2.0f, rect.size.height / 2.0f);
  CGFloat radius = MIN(rect.size.width, rect.size.height) / 2.0f;
  
  CGRect square;
  if (rect.size.width > rect.size.height)
  {
    square = CGRectMake((rect.size.width - rect.size.height) / 2.0, 0.0, rect.size.height, rect.size.height);
  }
  else
  {
    square = CGRectMake(0.0, (rect.size.height - rect.size.width) / 2.0, rect.size.width, rect.size.width);
  }
  
  
  CGFloat circleWidth = radius * _thicknessRatio;
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  
  if (_innerBackgroundColor)
  {
    // Fill innerCircle with innerBackgroundColor
    UIBezierPath *innerCircle = [UIBezierPath bezierPathWithArcCenter:center
                                                               radius:radius - circleWidth
                                                           startAngle:2*M_PI
                                                             endAngle:0.0
                                                            clockwise:YES];
    
    [_innerBackgroundColor setFill];
    
    [innerCircle fill];
  }
  
  if (_outerBackgroundColor)
  {
    // Fill outerCircle with outerBackgroundColor
    UIBezierPath *outerCircle = [UIBezierPath bezierPathWithArcCenter:center
                                                               radius:radius
                                                           startAngle:0.0
                                                             endAngle:2*M_PI
                                                            clockwise:NO];
    [outerCircle addArcWithCenter:center
                           radius:radius - circleWidth
                       startAngle:2*M_PI
                         endAngle:0.0
                        clockwise:YES];
    
    [_outerBackgroundColor setFill];
    
    [outerCircle fill];
  }

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  
    if (_maxProgress<=0)
    {
      _maxProgress = 100;
    }
    NSString *progressString = [[NSString stringWithFormat:@"%.0f", _progress * _maxProgress] stringByAppendingString:@"%"];
    
    CGFloat fontSize = radius;
    UIFont *font = [_font fontWithSize:fontSize];
    
    CGFloat diagonal = 2 * (radius - circleWidth);
    CGFloat edge = diagonal / sqrtf(2);
    
    CGFloat actualFontSize;
    CGSize maximumSize = CGSizeMake(edge, edge);
    CGSize expectedSize = [progressString sizeWithFont:font
                                           minFontSize:5.0
                                        actualFontSize:&actualFontSize
                                              forWidth:maximumSize.width
                                         lineBreakMode:NSLineBreakByWordWrapping];
    
    if (actualFontSize < fontSize)
    {
      font = [font fontWithSize:actualFontSize];
      expectedSize = [progressString sizeWithFont:font
                                      minFontSize:5.0
                                   actualFontSize:&actualFontSize
                                         forWidth:maximumSize.width
                                    lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    CGPoint origin = CGPointMake(center.x - expectedSize.width / 2.0, center.y - expectedSize.height / 2.0);
    
    [_textColor setFill];
    
    [progressString drawAtPoint:origin forWidth:expectedSize.width withFont:font lineBreakMode:NSLineBreakByWordWrapping];
  
  #pragma clang diagnostic pop
  UIBezierPath *path = [UIBezierPath bezierPath];
  
  
  [path appendPath:[UIBezierPath bezierPathWithArcCenter:center
                                                  radius:radius
                                              startAngle:DEGREES_TO_RADIANS(-90)
                                                endAngle:DEGREES_TO_RADIANS(progressAngle)
                                               clockwise:YES]];
  
  
  
  [path addArcWithCenter:center
                  radius:radius-circleWidth
              startAngle:DEGREES_TO_RADIANS(progressAngle)
                endAngle:DEGREES_TO_RADIANS(-90)
               clockwise:NO];
  
 
  [path closePath];
  
  if (_progressFillColor)
  {
    [_progressFillColor setFill];
    [path fill];
  }
  
  CGContextRestoreGState(context);
}

#pragma mark - Setter

- (void)setProgress:(double)progress
{
  _progress = MIN(1.0, MAX(0.0, progress));
  
  [self setNeedsDisplay];
}





- (void)setThicknessRatio:(CGFloat)thickness
{
  _thicknessRatio = MIN(MAX(0.0f, thickness), 1.0f);
  
  [self setNeedsDisplay];
}

- (void)setInnerBackgroundColor:(UIColor *)innerBackgroundColor
{
  _innerBackgroundColor = innerBackgroundColor;
  
  [self setNeedsDisplay];
}

- (void)setOuterBackgroundColor:(UIColor *)outerBackgroundColor
{
  _outerBackgroundColor = outerBackgroundColor;
  
  [self setNeedsDisplay];
}

- (void)setTextColor:(UIColor *)textColor
{
  _textColor = textColor;
  
  [self setNeedsDisplay];
}

- (void)setProgressFillColor:(UIColor *)progressFillColor
{
  _progressFillColor = progressFillColor;
  
  [self setNeedsDisplay];
}


-(void)setFillColorWithFromProgress:(double)fromprogress
                      andToProgress:(double)toprogress
                       andFillColor:(UIColor *)fillColor
{
  
  if (_progress*_maxProgress>=fromprogress && _progress*_maxProgress<=toprogress)
  {
    _progressFillColor = fillColor;
    [self setNeedsDisplay];
  }
  
}


@end
