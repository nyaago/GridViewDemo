//
//  GridCellVieq.m
//  GridViewDemo
//
//  Created by nyaago on 2013/10/02.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import "GridViewCell.h"
#import <QuartzCore/QuartzCore.h>

const NSString *kGridViewCellKind = @"GridViewCell";
const NSString *kGridViewRowHeaderCellKind = @"GridViewRowHeaderCell";
const NSString *kGridViewColumnHeaderCellKind = @"GridViewColumnHeaderCell";

@implementation GridViewCell

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    self.selectedBackgroundColor = [UIColor grayColor];
    self.activedBackgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.contentLabel];
    self.autoresizesSubviews = YES;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 0.5f;
  }
  return self;
}

/*!
 subviewsのレイアウトが必要なときの通知（リサイズ時など）
 subviewであるLabelのサイズ、フォントサイズを調整する。
 */
- (void)layoutSubviews {
  [super layoutSubviews];
//  NSLog(@"GridViewCell layoutSubviews");
  CGRect frame = self.frame;
  frame.origin.x = 0;
  frame.origin.y = 0;
  _contentLabel.frame = frame;
  _contentLabel.font = [UIFont systemFontOfSize:frame.size.height * 0.8f];
}

- (void) setSelected:(BOOL)selected {
  [super setSelected:selected];
  if(self.selected) {
    _contentLabel.backgroundColor = self.selectedBackgroundColor;
  }
  else {
    _contentLabel.backgroundColor = [self contentBackgroundColor];
  }
  if(self.actived) {
    _contentLabel.backgroundColor = self.activedBackgroundColor;
  }
}

- (void) setActived:(BOOL)actived {
  _actived = actived;
  if(self.actived) {
    NSLog(@"%@, %@", _contentLabel.backgroundColor, self.activedBackgroundColor);
    _contentLabel.backgroundColor = self.activedBackgroundColor;
  }
  else {
    if(self.selected) {
      _contentLabel.backgroundColor = self.selectedBackgroundColor;
    }
    else {
      _contentLabel.backgroundColor = [self contentBackgroundColor];
    }
  }
}


#pragma mark Properties

- (UILabel *) contentLabel {
  if(_contentLabel == nil) {
    CGRect frame = self.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    _contentLabel = [[GridCellLabel alloc] initWithFrame:frame];
    _contentLabel.font = [UIFont systemFontOfSize:20];
    _contentLabel.adjustsFontSizeToFitWidth = YES;
    _contentLabel.textAlignment = NSTextAlignmentRight;
  }
  return _contentLabel;
}

- (UIColor *)contentBackgroundColor {
  if(self.actived) {
    return self.activedBackgroundColor;
  }
  if(self.colorProvider) {

    
    UIColor *color = [self.colorProvider backgroundColorForValue:self.text];
    if(color) {
      return color;
    }
  }
  return self.backgroundColor;
}

- (void) setText:(NSString *)text {
  self.contentLabel.text = text;
  if(self.selected) {
    _contentLabel.backgroundColor = self.selectedBackgroundColor;
  }
  else {
    _contentLabel.backgroundColor = [self contentBackgroundColor];
  }
  if(self.actived) {
    _contentLabel.backgroundColor = self.activedBackgroundColor;
  }
}

- (NSString *)text {
  return self.contentLabel.text;
}

- (CGFloat) leftPadding {
  return self.contentLabel.leftPadding;
}

- (void) setLeftPadding:(CGFloat)leftPadding {
  self.contentLabel.leftPadding = leftPadding;
}

- (CGFloat) rightPadding {
  return self.contentLabel.rightPadding;
}

- (void) setRightPadding:(CGFloat)rightPadding {
  self.contentLabel.rightPadding = rightPadding;
}

- (void) setBorderColor:(UIColor *)borderColor {
  self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *) borderColor {
  return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void) setBorderWidth:(CGFloat)borderWidth {
  self.layer.borderWidth = borderWidth;
}

- (CGFloat) borderWidth {
  return self.layer.borderWidth;
}

#pragma mark class Methods

+ (NSString *)kind {
  return (NSString *)kGridViewCellKind;
}

+ (NSString *)rowHeaderKind {
  return (NSString *)kGridViewRowHeaderCellKind;
}

+ (NSString *)columnHeaderKind {
  return (NSString *)kGridViewColumnHeaderCellKind;
}


@end
