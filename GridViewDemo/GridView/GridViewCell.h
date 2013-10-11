//
//  GridCellVieq.h
//  GridViewDemo
//
//  Created by nyaago on 2013/10/02.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridCellLabel.h"

@interface GridViewCell : UICollectionViewCell

/*!
 CellのReuseのためのキャッシュに使う識別値
 */
+ (NSString *)kind;

/*!
 CellのReuseのためのキャッシュに使う識別値 - 行ヘッダー用
 */
+ (NSString *)rowHeaderKind;

/*!
 CellのReuseのためのキャッシュに使う識別値 - 列ヘッダー用
 */
+ (NSString *)columnHeaderKind;


/*!
 Cell内に配置するlabel view
 */
@property (nonatomic, strong) GridCellLabel *contentLabel;
/*!
 The text displayed in the cell.
 */
@property (nonatomic, strong) NSString *text;

/*!
  the padding space required on the right side of an element.
 */
@property (nonatomic, assign) CGFloat rightPadding;
/*!
  the padding space required on the left side of an element.
 */
@property (nonatomic, assign) CGFloat leftPadding;

@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, weak) UIColor *borderColor;

@end
