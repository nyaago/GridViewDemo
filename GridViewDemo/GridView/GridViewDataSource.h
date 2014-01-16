//
//  GridViewDataSource.h
//  GridViewDemo
//
//  Created by nyaago on 2013/10/03.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GridCellColorProvider.h"

/*!
 Gridに表示するデータを提供するプロトコル
 */
@protocol GridDataSource <NSObject>

/*!
 @return 行数
 */
- (NSInteger) rowCount;

/*!
 @return 列数
 */
- (NSInteger) columnCount;

/*!
 @param row
 @param column
 @return 指定行列の値
 */
- (NSString *) valueAtRow:(NSInteger)row atColumn:(NSInteger)column;

@optional

/*!
 @param value 指定行列に設定する値
 @param row
 @param column
 */
- (void) setValue:(NSString *)value atRow:(NSInteger)row atColumn:(NSInteger)column;

/*!
 @param row 行Index(0 base)
 @return 指定行のタイトル
 */
- (NSString *) rowTitleAt:(NSInteger)row;


/*!
 @param column 列Index(0 base)
 @return 指定列のタイトル
 */
- (NSString *) columnTitleAt:(NSInteger)column;

@optional

- (BOOL) activeAtRow:(NSInteger)row atColumn:(NSInteger)column;
- (void) clearActive;
- (void) setActiveAtRow:(NSInteger)row atColumn:(NSInteger)column;
- (NSInteger) activeCellRow;
- (NSInteger) activeCellColumn;

@end

/*!
 GridViewのデータソース
 */
@interface GridViewDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, strong) NSObject<GridDataSource> *source;
@property (nonatomic, weak) NSObject<GridCellColorProvider> *colorProvider;


@end

/*!
 GridViewの行ヘッダーデータソース
 */
@interface GridRowHeaderDataSource : NSString <UICollectionViewDataSource>

@property (nonatomic, strong) NSObject<GridDataSource> *source;

@end

/*!
 GridViewの列ヘッダーデータソース
 */
@interface GridColumnHeaderDataSource : NSString <UICollectionViewDataSource>

@property (nonatomic, strong) NSObject<GridDataSource> *source;


@end
