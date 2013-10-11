//
//  GridView.m
//  GridViewDemo
//
//  Created by nyaago on 2013/10/03.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import "GridView.h"

@interface GridView()

@property (nonatomic, strong) UIPinchGestureRecognizer *pinchGestureRecognizer;

@end

@implementation GridView

@synthesize pinchGestureRecognizer;

- (id) initWithFrame:(CGRect)frame gridLayout:(GridLayout *)layout {
  self = [super initWithFrame:frame collectionViewLayout:layout];
  if(self) {
    _layout = layout;
    _respondToPinch = YES;
    [self initProperties];
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark Properties

- (void) setRespondToPinch:(BOOL)respondToPinch {
  if(respondToPinch != _respondToPinch) {
    if(respondToPinch == YES) {
     [self addGestureRecognizer:self.pinchGestureRecognizer];
    }
    else {
      [self removeGestureRecognizer:self.pinchGestureRecognizer];
    }
  }
  _respondToPinch = respondToPinch;
}

#pragma mark Action

- (void)pinchAction : (UIPinchGestureRecognizer *)sender {
  if(_layout) {
    CGFloat scale = [sender scale];
    NSLog(@"pinch - scale = %f", scale);
    if(self.gestureDelegate) {
      if([self.gestureDelegate respondsToSelector:@selector(gridView:pinchGestured:)]) {
        [self.gestureDelegate gridView:self pinchGestured:self.pinchGestureRecognizer];
      }
    }
    else {
      _layout.scale = _layout.scale * scale;
      [_layout invalidateLayout];
    }
    
  }
}

#pragma mark  Private

- (void) initProperties {
  self.pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc]
                                 initWithTarget:self action:@selector(pinchAction:)];
  [self addGestureRecognizer:self.pinchGestureRecognizer];
}

@end
