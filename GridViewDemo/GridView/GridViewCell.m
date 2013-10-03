//
//  GridCellVieq.m
//  GridViewDemo
//
//  Created by nyaago on 2013/10/02.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import "GridViewCell.h"

const NSString *kGridViewCellKind = @"GridViewCell";
@implementation GridViewCell

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    [self.contentView addSubview:self.contentLabel];
    self.autoresizesSubviews = YES;
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

- (void) setText:(NSString *)text {
  self.contentLabel.text = text;
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

#pragma mark class Methods

+ (NSString *)kind {
  return (NSString *)kGridViewCellKind;
}


@end
