//
//  GridView.h
//  GridViewDemo
//
//  Created by nyaago on 2013/10/03.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridLayout.h"

@class GridView;
/*!
 Gesture 操作をデレゲート
 */
@protocol GridViewGestureDelegate <NSObject>

- (void) gridView:(GridView *)view pinchGestured:(UIPinchGestureRecognizer *)gestureRecognizer;

@end

@interface GridView : UICollectionView


- (id) initWithFrame:(CGRect)frame gridLayout:(GridLayout *)layout;

@property (nonatomic) BOOL respondToPinch;
@property (nonatomic) BOOL forwardPinchGesture;
@property (nonatomic, weak) GridLayout *layout;
@property (nonatomic, weak) NSObject<GridViewGestureDelegate> *gestureDelegate;

@end
