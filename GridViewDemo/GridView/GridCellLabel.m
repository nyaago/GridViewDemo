//
//  GridCellLabel.m
//  GridViewDemo
//
//  Created by nyaago on 2013/10/04.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "GridCellLabel.h"

@implementation GridCellLabel

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _leftPadding = 5.0f;
    _rightPadding = 5.0f;
   self.backgroundColor = [UIColor whiteColor];
  }
  return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
  UIEdgeInsets insets = {0, self.leftPadding, 0, self.rightPadding};
  return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
