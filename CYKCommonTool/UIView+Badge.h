//
//  UIView+Badge.h
//  PPAppInstall2
//
//  Created by zadmin on 15/6/27.
//  Copyright (c) 2015年 kang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Badge)


/**
 *  设置角标左约束值和底部约束值
 *
 *  @param leftMargin   左边
 *  @param bottomMargin 顶部
 */
- (void) addBadgeConstraintLeftMargin:(CGFloat)leftMargin bottomMargin:(CGFloat)bottomMargin;

/**
 *  设置bage颜色
 *
 *  @param color 颜色值
 */
- (void) updateBageColor:(UIColor *)color;

/**
 *  设置为等于0表示小红点，大于0表示带数字角标，超过99表示为99+，小于0就隐藏角标
 */
@property (nonatomic, assign) NSInteger badge;


@end
