//
//  GridDemoDataSource.m
//  GridViewDemo
//
//  Created by nyaago on 2013/10/03.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import "GridDemoDataSource.h"

@implementation GridDemoDataSource

- (NSInteger) rowCount {
  return 30;
}

- (NSInteger) columnCount {
  return 20;
}

- (NSString *) valueAtRow:(NSInteger)row atColumn:(NSInteger)column {
  NSString *s = [NSString stringWithFormat:@"%d-%d", row, column];
  return s;
}


@end
