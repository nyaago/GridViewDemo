//
//  GridCellInfo.h
//  ienigma
//
//  Created by nyaago on 2013/12/12.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GridCellInfo : NSObject

@property (nonatomic)  int row;
@property (nonatomic)  int column;

- (id) initWithRow:(int)row column:(int) column;

@end
