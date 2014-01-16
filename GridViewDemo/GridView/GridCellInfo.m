//
//  GridCellInfo.m
//  ienigma
//
//  Created by nyaago on 2013/12/12.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import "GridCellInfo.h"

@implementation GridCellInfo


- (id) initWithRow:(int)row column:(int) column {
  self = [super init];
  if(self != nil) {
    self.row = row;
    self.column = column;
  }
  return self;
}

@end
