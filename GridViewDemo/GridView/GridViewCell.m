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

- (void)layoutSubviews {
  [super layoutSubviews];
  NSLog(@"GridViewCell layoutSubviews");
}


+ (NSString *)kind {
  return (NSString *)kGridViewCellKind;
}

- (UILabel *) contentLabel {
  if(_contentLabel == nil) {
    CGRect frame = self.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    _contentLabel = [[UILabel alloc] initWithFrame:frame];
  }
  return _contentLabel;
}

- (void) setText:(NSString *)text {
  self.contentLabel.text = text;
}

- (NSString *)text {
  return self.contentLabel.text;
}


@end
