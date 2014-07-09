/*!
 @header WAProgressView.h
 @abstract  进度条控件
 @discussion
 @author chenrh1
 @copyright
 @version	1.0 2014-07-09 11:20:26 Creation
 */

#import <UIKit/UIKit.h>


@interface WAProgressView : UIView

/*!
 	@property
 	@abstract	progress	进度条数字
 */
@property (nonatomic) double progress;


/*!
 	@property
 	@abstract		进度条最大值 默认100
 */
@property (nonatomic) CGFloat maxProgress ;


/*!
 	@property
 	@abstract	UI_APPEARANCE_SELECTOR	进度条环的宽度与最外层环的半径的比例，默认是0.37
 */
@property (nonatomic) CGFloat thicknessRatio UI_APPEARANCE_SELECTOR;


/*!
 	@property
 	@abstract	innerBackgroundColor UI_APPEARANCE_SELECTOR	内圈（显示文字）的背景颜色
 */
@property (nonatomic, strong) UIColor *innerBackgroundColor UI_APPEARANCE_SELECTOR;

/*!
 	@property
 	@abstract	outerBackgroundColor UI_APPEARANCE_SELECTOR	外圈（进度条）的背景颜色
 */
@property (nonatomic, strong) UIColor *outerBackgroundColor UI_APPEARANCE_SELECTOR;


/*!
 	@property
 	@abstract	textColor UI_APPEARANCE_SELECTOR	文字颜色
 */
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;

/*!
 	@property
 	@abstract	font UI_APPEARANCE_SELECTOR	文字字体
 */
@property (nonatomic, strong) UIFont *font UI_APPEARANCE_SELECTOR;


/*!
 	@property
 	@abstract	progressFillColor UI_APPEARANCE_SELECTOR	进度条的颜色
 */
@property (nonatomic, strong) UIColor *progressFillColor UI_APPEARANCE_SELECTOR;

/*!
 	@method
 	@abstract	更改进度条的属性
 	@discussion
 	@param 	thicknessRatio 	进度条环的宽度与最外层环的半径的比例，默认是0.37
 	@param 	innerBgColor 	内圈（显示文字）的背景颜色 默认灰色
 	@param 	outBgColor 	外圈（进度条）的背景颜色 默认紫色
 	@param 	textColor 	文字颜色 默认黑色
 	@param 	aFount 	文字字体 默认系统10号字
 	@param 	fillColor 	进度条的颜色
 	@result
 */
-(void)setAttrWithThicknessRatio:(CGFloat)thicknessRatio
                 andInberBgColor:(UIColor *)innerBgColor
                   andOutBgColor:(UIColor *)outBgColor
                    andTextColor:(UIColor *)textColor
                         andFont:(UIFont *)aFount
            andProgressFillColor:(UIColor *)fillColor;


/*!
 	@method
 	@abstract 根据进度条进度 改变进度条的颜色
 	@discussion
 	@param 	fromprogress 	开始范围
 	@param 	toprogress 	结束范围
 	@param 	fillColor 	背景条颜色
 	@result
 */
-(void)setFillColorWithFromProgress:(double)fromprogress
                      andToProgress:(double)toprogress
                       andFillColor:(UIColor *)fillColor;

@end
