//
//  QCircularProgressView.h
//  QExtension
//
//  Created by JHQ0228 on 2017/4/3.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


#pragma mark - QCircularProgressView

IB_DESIGNABLE

/**
 * The QCircularProgressBarView class is a UIView subclass that draws a circular progress bar with configurable attributes.
 * You can change the attributes within the Interface Builder using IBDesignables.
 * https://developer.apple.com/library/ios/recipes/xcode_help-IB_objects_media/Chapters/CreatingaLiveViewofaCustomObject.html
 */

@interface QCircularProgressView : UIView

#pragma mark angle

/// Set a partial angle for the progress bar, Range [0, 100]
@property (nonatomic, assign) IBInspectable CGFloat     progressAngle;

/// Progress bar rotation (Clockewise), Range [0, 100]
@property (nonatomic, assign) IBInspectable CGFloat     progressRotationAngle;

#pragma mark value

/// Should show value string
@property (nonatomic, assign) IBInspectable BOOL        showValueString;

/// Should show target value string
@property (nonatomic, assign) IBInspectable BOOL        showTargetValueString;

/// Should show mark value string
@property (nonatomic, assign) IBInspectable BOOL        showMarkValueString;

/// The value of the progress bar (Animatable property using [UIView animateWithDuration:])
@property (nonatomic, assign) IBInspectable CGFloat     value;

/// The value of the inside progress bar
@property (nonatomic, assign) IBInspectable CGFloat     insideValue;

/// The value of the outside progress bar
@property (nonatomic, assign) IBInspectable CGFloat     outsideValue;

/// The maximum possible value, used to calculate the progress (value/maxValue), Range [0, ∞)
@property (nonatomic, assign) IBInspectable CGFloat     maxValue;

/// The target value of the progress bar
@property (nonatomic, assign) IBInspectable CGFloat     targetValue;

/// The font size of the value text, Range [0, ∞)
@property (nonatomic, assign) IBInspectable CGFloat     valueFontSize;

/// The font name of the value text
@property (nonatomic, copy)   IBInspectable NSString    *valueFontName;

/// The font color of the value text
@property (nonatomic, strong) IBInspectable UIColor     *valueFontColor;

/// The offset to apply to the value text
@property (nonatomic, assign) IBInspectable CGPoint     valueOffset;

/// Should show max value decimal string
@property (nonatomic, assign) IBInspectable BOOL        showValueDecimal;

/// Number of decimal places of the value, Range [0, ∞)
@property (nonatomic, assign) IBInspectable NSInteger   valueDecimalPlaces;

/// The font size of the valueDecimal text, Range [0, ∞)
@property (nonatomic,assign)  IBInspectable CGFloat     valueDecimalFontSize;

/// Show label value as countdown, Default is NO
@property (nonatomic, assign) IBInspectable BOOL        countdown;

#pragma mark unit

/// Should show unit screen
@property (nonatomic, assign) IBInspectable BOOL        showUnitString;

/// The string that represents the units, usually %
@property (nonatomic, copy)   IBInspectable NSString    *unitString;

/// The font size of the unit text, Range [0, ∞)
@property (nonatomic, assign) IBInspectable CGFloat     unitFontSize;

/// The name of the font of the unit text
@property (nonatomic, copy)   IBInspectable NSString    *unitFontName;

/// The color of the value and unit text
@property (nonatomic, strong) IBInspectable UIColor     *unitFontColor;

/// The offset to apply to the unit text
@property (nonatomic, assign) IBInspectable CGPoint     unitOffset;

#pragma mark empty

/// The width of the background bar (user space units), Range [0, ∞)
@property (nonatomic, assign) IBInspectable CGFloat     emptyLineWidth;

/// The color of the background bar
@property (nonatomic, strong) IBInspectable UIColor     *emptyLineColor;

/// The color of the background bar stroke color
@property (nonatomic, strong) IBInspectable UIColor     *emptyLineStrokeColor;

/// The shape of the background bar cap	{kCGLineCapButt=0, kCGLineCapRound=1, kCGLineCapSquare=2}
@property (nonatomic, assign) IBInspectable NSInteger   emptyLineCapType;

#pragma mark inside

/// The width of the inside bar, Range [0, ∞)
@property (nonatomic, assign) IBInspectable CGFloat     insideLineWidth;

/// The color of the inside bar
@property (nonatomic, strong) IBInspectable UIColor     *insideLineColor;

/// The color of the inside bar stroke line
@property (nonatomic, strong) IBInspectable UIColor     *insideLineStrokeColor;

/// The shape of the inside bar cap	{kCGLineCapButt=0, kCGLineCapRound=1, kCGLineCapSquare=2}
@property (nonatomic, assign) IBInspectable NSInteger   insideLineCapType;

#pragma mark outside

/// The width of the outside bar, Range [0, ∞)
@property (nonatomic, assign) IBInspectable CGFloat     outsideLineWidth;

/// The color of the outside bar
@property (nonatomic, strong) IBInspectable UIColor     *outsideLineColor;

/// The color of the outside bar stroke line
@property (nonatomic, strong) IBInspectable UIColor     *outsideLineStrokeColor;

/// The shape of the outside bar cap {kCGLineCapButt=0, kCGLineCapRound=1, kCGLineCapSquare=2}
@property (nonatomic, assign) IBInspectable NSInteger   outsideLineCapType;

@end


/*******************************************************************************/

#pragma mark - QCircularProgressLayer

@interface QCircularProgressLayer : CALayer

/**
 * The QCircularProgressLayer class is a CALayer subclass that represents the underlying layer of QCircularProgressBarView.
 */

#pragma mark angle

/// Set a partial angle for the progress bar, Range [0, 100]
@property (nonatomic, assign) CGFloat   progressAngle;

/// Progress bar rotation (Clockewise), Range [0, 100]
@property (nonatomic, assign) CGFloat   progressRotationAngle;

#pragma mark animation

/// Animation duration in seconds
@property (nonatomic, assign) NSTimeInterval animationDuration;

#pragma mark value

/// Should show value string
@property (nonatomic, assign) BOOL      showValueString;

/// Should show target value string
@property (nonatomic, assign) BOOL      showTargetValueString;

/// Should show mark value string
@property (nonatomic, assign) BOOL      showMarkValueString;

/// The value of the progress bar
@property (nonatomic, assign) CGFloat   value;

/// The value of the inside progress bar
@property (nonatomic, assign) CGFloat   insideValue;

/// The value of the outside progress bar
@property (nonatomic, assign) CGFloat   outsideValue;

/// The maximum possible value, used to calculate the progress (value/maxValue), Range [0, ∞)
@property (nonatomic, assign) CGFloat   maxValue;

/// The target value of the progress bar
@property (nonatomic, assign) CGFloat   targetValue;

/// The font size of the value text, Range [0, ∞)
@property (nonatomic, assign) CGFloat   valueFontSize;

/// The font name of the value text
@property (nonatomic, copy)   NSString  *valueFontName;

/// The font color of the value text
@property (nonatomic, strong) UIColor   *valueFontColor;

/// The offset to apply to the value text
@property (nonatomic, assign) CGPoint   valueOffset;

/// Should show max value decimal string
@property (nonatomic, assign) BOOL      showValueDecimal;

/// Number of decimal places of the value, Range [0, ∞)
@property (nonatomic, assign) NSInteger valueDecimalPlaces;

/// The font size of the valueDecimal text, Range [0, ∞)
@property (nonatomic, assign) CGFloat   valueDecimalFontSize;

/// Show label value as countdown, Default is NO
@property (nonatomic, assign) BOOL      countdown;

#pragma mark unit

/// Should show unit screen
@property (nonatomic, assign) BOOL      showUnitString;

/// The string that represents the units, usually %
@property (nonatomic, copy)   NSString  *unitString;

/// The font size of the unit text, Range [0, ∞)
@property (nonatomic, assign) CGFloat   unitFontSize;

/// The font name of the unit text
@property (nonatomic, copy)   NSString  *unitFontName;

/// The font color of the unit text
@property (nonatomic, strong) UIColor   *unitFontColor;

/// The offset to apply to the unit text
@property (nonatomic, assign) CGPoint   unitOffset;

#pragma mark empty

/// The width of the background bar (user space units), Range [0, ∞)
@property (nonatomic, assign) CGFloat   emptyLineWidth;

/// The color of the background bar
@property (nonatomic, strong) UIColor   *emptyLineColor;

/// The color of the background bar stroke line
@property (nonatomic, strong) UIColor   *emptyLineStrokeColor;

/// The shape of the background bar cap	{kCGLineCapButt=0, kCGLineCapRound=1, kCGLineCapSquare=2}
@property (nonatomic, assign) CGLineCap emptyLineCapType;

#pragma mark inside

/// The width of the inside bar, Range [0, ∞)
@property (nonatomic, assign) CGFloat   insideLineWidth;

/// The color of the inside bar
@property (nonatomic, strong) UIColor   *insideLineColor;

/// The color of the inside bar stroke line
@property (nonatomic, strong) UIColor   *insideLineStrokeColor;

/// The shape of the inside bar cap	{kCGLineCapButt=0, kCGLineCapRound=1, kCGLineCapSquare=2}
@property (nonatomic, assign) CGLineCap insideLineCapType;

#pragma mark outside

/// The width of the outside bar, Range [0, ∞)
@property (nonatomic, assign) CGFloat   outsideLineWidth;

/// The color of the outside bar
@property (nonatomic, strong) UIColor   *outsideLineColor;

/// The color of the outside bar stroke line
@property (nonatomic, strong) UIColor   *outsideLineStrokeColor;

/// The shape of the outside bar cap {kCGLineCapButt=0, kCGLineCapRound=1, kCGLineCapSquare=2}
@property (nonatomic, assign) CGLineCap outsideLineCapType;

@end


NS_ASSUME_NONNULL_END
