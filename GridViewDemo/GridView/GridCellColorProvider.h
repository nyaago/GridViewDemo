//
//  GridCellColorProvider.h
//  ienigma
//
//  Created by nyaago on 2013/11/12.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GridCellColorProvider <NSObject>

/**
 * 指定セルの背景色
 */
- (UIColor *) backgroundColorForValue:(NSString *)value;

@optional
/**
 * 指定セルの背景色
 */
- (UIColor *) backgroundColorOfActive;


@end
