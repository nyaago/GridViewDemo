//
//  GridView.m
//  GridViewDemo
//
//  Created by nyaago on 2013/10/03.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import "GridView.h"

@interface GridView() {
  UIPinchGestureRecognizer *_pinchGestureRecognizer;
}

@property (nonatomic, strong) UIPinchGestureRecognizer *pinchGestureRecognizer;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGestureRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;


@end

@implementation GridView

//@synthesize pinchGestureRecognizer;

- (id) initWithFrame:(CGRect)frame gridLayout:(GridLayout *)layout {
  self = [super initWithFrame:frame collectionViewLayout:layout];
  if(self) {
    _layout = layout;
    _respondToPinch = YES;
    _respondToLongPress = YES;
    _respondToTap = NO;
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

// メニューの表示ができるよう First Responder になれる。
- (BOOL) canBecomeFirstResponder {
  return YES;
}

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

- (void) setRespondToLongPress:(BOOL)respondToLongPress {
  if(respondToLongPress != _respondToLongPress) {
    if(respondToLongPress == YES) {
      [self addGestureRecognizer:self.longPressGestureRecognizer];
    }
    else {
      [self removeGestureRecognizer:self.longPressGestureRecognizer];
    }
  }
  _respondToLongPress = respondToLongPress;
}

- (void) setRespondToTap:(BOOL)respondToTap {
  if(respondToTap != _respondToTap) {
    if(respondToTap == YES) {
      [self addGestureRecognizer:self.tapGestureRecognizer];
    }
    else {
      [self removeGestureRecognizer:self.tapGestureRecognizer];
    }
  }
  _respondToTap = respondToTap;
}


- (UIPinchGestureRecognizer *)pinchGestureRecognizer {
  if(_pinchGestureRecognizer == nil) {
    _pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(pinchAction:)];
    [self addGestureRecognizer:_pinchGestureRecognizer];
  }
  return _pinchGestureRecognizer;
}

- (void) setPinchGestureRecognizer:(UIPinchGestureRecognizer *)pinchGestureRecognizer {
  _pinchGestureRecognizer = pinchGestureRecognizer;
}


- (UILongPressGestureRecognizer *)longPressGestureRecognizer {
  if(_longPressGestureRecognizer == nil) {
    _longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(longPressAction:)];
    [self addGestureRecognizer:_longPressGestureRecognizer];
  }
  return _longPressGestureRecognizer;
}

- (UITapGestureRecognizer *) tapGestureRecognizer {
  if(_tapGestureRecognizer == nil) {
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                              initWithTarget:self
                             action:@selector(tapAction:)];
    [self addGestureRecognizer:_tapGestureRecognizer];
  }
  return _tapGestureRecognizer;
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

- (void)longPressAction : (UILongPressGestureRecognizer *)sender {
  if(self.gestureDelegate) {
    if([self.gestureDelegate respondsToSelector:@selector(gridView:longPressGestured:)]) {
      [self.gestureDelegate gridView:self longPressGestured:sender];
    }
  }
}

- (void)tapAction : (UITapGestureRecognizer *)sender {
  if(self.gestureDelegate) {
    if([self.gestureDelegate respondsToSelector:@selector(gridView:tapGestured:)]) {
      [self.gestureDelegate gridView:self tapGestured:sender];
    }
  }
}

#pragma mark  Private

- (void) initProperties {
  [self pinchGestureRecognizer];
  [self longPressGestureRecognizer];
//  [self tapGestureRecognizer];
}

@end
