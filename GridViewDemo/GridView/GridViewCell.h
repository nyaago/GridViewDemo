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
 Cell内に配置するlabel view
 */
@property (nonatomic, strong) GridCellLabel *contentLabel;
/*!
 表示テキスト
 */
@property (nonatomic, strong) NSString *text;

/*!
 右側のPadding
 */
@property (nonatomic, assign) CGFloat rightPadding;
/*!
 左側のPadding
 */
@property (nonatomic, assign) CGFloat leftPadding;

@end
