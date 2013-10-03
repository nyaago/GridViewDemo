//
//  GridViewDataSource.h
//  GridViewDemo
//
//  Created by nyaago on 2013/10/03.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import <Foundation/Foundation.h>

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


@end

@interface GridViewDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, strong) NSObject<GridDataSource> *source;

@end
