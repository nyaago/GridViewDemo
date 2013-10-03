//
//  GridLayout.h
//  GridViewDemo
//
//  Created by nyaago on 2013/10/02.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridViewDataSource.h"

@interface GridLayout : UICollectionViewLayout

/*!
 */
@property (nonatomic) CGSize itemSize;

/*!
 The spacing to use between items in the same row.
 */
@property (nonatomic) CGFloat itemSpacing;

/*!
 The spacing to use between lines of items in the grid.
 */
@property (nonatomic) CGFloat lineSpacing;

/*!
 The number of columns
 */
@property (nonatomic) NSInteger numberOfColumns;

//@property (nonatomic, strong) NSObject<GridDataSource> *source;

@property (nonatomic) CGPoint pinchPoint;
@property (nonatomic) CGFloat pinchScale;

@end
