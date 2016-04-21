//
//  UIView+Badge.m
//  PPAppInstall2
//
//  Created by zadmin on 15/6/27.
//  Copyright (c) 2015年 kang. All rights reserved.
//

#import "UIView+Badge.h"
#import <objc/runtime.h>
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"

@interface UIView ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) NSMutableArray *updateConstraintArray;


@end

@implementation UIView (Badge)

static char bgViewKey;
- (void) setBgView:(UIView *)bgView
{
    objc_setAssociatedObject(self, &bgViewKey, bgView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)bgView
{
    return objc_getAssociatedObject(self, &bgViewKey);
}

static char numberLabelKey;
- (void) setNumberLabel:(UILabel *)numberLabel
{
    objc_setAssociatedObject(self, &numberLabelKey, numberLabel, OBJC_ASSOCIATION_RETAIN);
}

- (UILabel *) numberLabel
{
    return objc_getAssociatedObject(self, &numberLabelKey);
}

static char updateConstraintArrayKey;
- (void) setUpdateConstraintArray:(NSMutableArray *)updateConstraintArray
{
    objc_setAssociatedObject(self, &updateConstraintArrayKey, updateConstraintArray, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableArray *)updateConstraintArray
{
    return objc_getAssociatedObject(self, &updateConstraintArrayKey);
}

- (void) addBadgeConstraintLeftMargin:(CGFloat)leftMargin bottomMargin:(CGFloat)bottomMargin
{
    self.updateConstraintArray = [NSMutableArray array];
    self.clipsToBounds = NO;
    if (self.bgView == nil)
    {
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor redColor];
        self.bgView.hidden = YES;
        [self addSubview:self.bgView];
        
        self.numberLabel = ({
            UILabel *aLabel = [[UILabel alloc] init];
            aLabel.font = [UIFont systemFontOfSize:9];
            aLabel.textColor = [UIColor whiteColor];
            aLabel.textAlignment = NSTextAlignmentCenter;
            aLabel;
        });
        [self addSubview:self.numberLabel];
        self.numberLabel.hidden = YES;
    }
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        [self.updateConstraintArray addObject:make.left.equalTo(leftMargin)];
        [self.updateConstraintArray addObject:@(leftMargin)];
        [self.updateConstraintArray addObject:make.bottom.equalTo(bottomMargin)];
        [self.updateConstraintArray addObject:@(bottomMargin)];
        make.width.equalTo(10);
        make.height.equalTo(10);
    }];
    
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
    
    [self.numberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bgView);
    }];
}

- (void) updateBageColor:(UIColor *)color
{
    self.bgView.backgroundColor = color;
}

static char badgeKey;
- (void) setBadge:(NSInteger)badge
{
    self.bgView.hidden = NO;
    self.numberLabel.hidden = NO;
    NSValue *value = [NSValue value:&badge withObjCType:@encode(NSInteger)];
    objc_setAssociatedObject(self, &badgeKey, (id)value, OBJC_ASSOCIATION_COPY);
    
    if (badge == 0)
    {
        self.numberLabel.alpha = 0.f;
        [self.bgView updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(8);
            make.height.equalTo(8);
        }];
        MASConstraint *leftConstraint = [self.updateConstraintArray objectAtIndex:0];
        CGFloat left = [[self.updateConstraintArray objectAtIndex:1] floatValue];
        leftConstraint.offset = left + 4;
        MASConstraint *bottomConstraint = [self.updateConstraintArray objectAtIndex:2];
        CGFloat bottom = [[self.updateConstraintArray objectAtIndex:3] floatValue];
        bottomConstraint.offset = bottom - 4;
        
        self.bgView.layer.cornerRadius = 4;
        self.bgView.layer.masksToBounds = YES;
    }else if (badge < 0)
    {
        self.bgView.hidden = YES;
        self.numberLabel.hidden = YES;
    }else if (badge > 99)
    {
        self.numberLabel.alpha = 1.f;
        self.numberLabel.text = @"99+";
        [self.numberLabel sizeToFit];
        [self.bgView updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.numberLabel.bounds.size.width + 6);
            make.height.equalTo(14);
        }];
        
        MASConstraint *leftConstraint = [self.updateConstraintArray objectAtIndex:0];
        CGFloat left = [[self.updateConstraintArray objectAtIndex:1] floatValue];
        leftConstraint.offset = left;
        MASConstraint *bottomConstraint = [self.updateConstraintArray objectAtIndex:2];
        CGFloat bottom = [[self.updateConstraintArray objectAtIndex:3] floatValue];
        bottomConstraint.offset = bottom;
        
        self.bgView.layer.cornerRadius = 7;
        self.bgView.layer.masksToBounds = YES;
    }else if (badge < 10)
    {
        self.numberLabel.alpha = 1.f;
        self.numberLabel.text = [NSString stringWithFormat:@"%ld", (long)badge];
        [self.numberLabel sizeToFit];
        [self.bgView updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(15);
            make.height.equalTo(15);
        }];
        
        MASConstraint *leftConstraint = [self.updateConstraintArray objectAtIndex:0];
        CGFloat left = [[self.updateConstraintArray objectAtIndex:1] floatValue];
        leftConstraint.offset = left;
        MASConstraint *bottomConstraint = [self.updateConstraintArray objectAtIndex:2];
        CGFloat bottom = [[self.updateConstraintArray objectAtIndex:3] floatValue];
        bottomConstraint.offset = bottom;
        
        self.bgView.layer.cornerRadius = 7.5;
        self.bgView.layer.masksToBounds = YES;
    }else
    {
        self.numberLabel.alpha = 1.f;
        self.numberLabel.text = [NSString stringWithFormat:@"%ld", (long)badge];
        [self.numberLabel sizeToFit];
        [self.bgView updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.numberLabel.bounds.size.width + 6);
            make.height.equalTo(14);
        }];
        
        MASConstraint *leftConstraint = [self.updateConstraintArray objectAtIndex:0];
        CGFloat left = [[self.updateConstraintArray objectAtIndex:1] floatValue];
        leftConstraint.offset = left;
        MASConstraint *bottomConstraint = [self.updateConstraintArray objectAtIndex:2];
        CGFloat bottom = [[self.updateConstraintArray objectAtIndex:3] floatValue];
        bottomConstraint.offset = bottom;
        
        self.bgView.layer.cornerRadius = 7.2;
        self.bgView.layer.masksToBounds = YES;
    }
}

- (NSInteger) badge
{
    NSValue *value = objc_getAssociatedObject(self, &badgeKey);
    NSInteger number = 0;
    [value getValue:&number];
    return number;
}

@end
