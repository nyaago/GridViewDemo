//
//  ItemGridViewController.h
//  GridViewDemo
//
//  Created by nyaago on 2013/10/10.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridViewDataSource.h"
#import "GridView.h"


@interface ItemGridViewController : UIViewController <GridViewGestureDelegate, UICollectionViewDelegate>  {

NSObject<GridDataSource> *_source;
}

//- (id)initWithFrame:(CGRect)frame;

@property (nonatomic, strong)   GridViewDataSource *viewDataSource;

@property (nonatomic) NSObject<GridDataSource> *source;
@property (nonatomic) CGFloat minScale;
@property (nonatomic) CGFloat maxScale;
@property (nonatomic) BOOL allowsMultipleSelection;
@property (nonatomic) BOOL allowsSelection;
@property (nonatomic) BOOL allowsRowSelection;
@property (nonatomic) BOOL allowsColumnSelection;
@property (nonatomic) BOOL autosizing;
@property (nonatomic) CGFloat contentsTop;

@property (nonatomic, strong) GridView *gridView;

- (void) clearSelection;

// @deprecated
- (BOOL) isSelectedWithRow:(NSInteger)row column:(NSInteger)column;

/**
 * @return 選択セルの行列情報(GridCellInfo)の配列
 */
- (NSArray *) selectedGridCellInfos;

/**
 */
- (BOOL) isSelectedWithRow:(NSInteger)row column:(NSInteger)column
             gridCellInfos:(NSArray *) gridCellInfos;


@end
