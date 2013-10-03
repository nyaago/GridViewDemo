//
//  GridView.h
//  GridViewDemo
//
//  Created by nyaago on 2013/10/03.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridLayout.h"

@interface GridView : UICollectionView


- (id) initWithFrame:(CGRect)frame gridLayout:(GridLayout *)layout;

@end
