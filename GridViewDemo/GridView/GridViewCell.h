//
//  GridCellVieq.h
//  GridViewDemo
//
//  Created by nyaago on 2013/10/02.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridViewCell : UICollectionViewCell

+ (NSString *)kind;

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) NSString *text;

@end
