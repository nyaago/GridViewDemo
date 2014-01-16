//
//  GridCellLabel.h
//  GridViewDemo
//
//  Created by nyaago on 2013/10/04.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import <UIKit/UIKit.h>
/*!
 GridView用のUILabel拡張
 @class GridCellLabel
 @description Padding を行うよう UILable 拡張を行う。
 */
@interface GridCellLabel : UILabel

/*!
 右側のPadding
 */
@property (nonatomic, assign) CGFloat rightPadding;
/*!
 左側のPadding
 */
@property (nonatomic, assign) CGFloat leftPadding;


@end
