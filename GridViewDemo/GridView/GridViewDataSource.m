//
//  GridViewDataSource.m
//  GridViewDemo
//
//  Created by nyaago on 2013/10/03.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import "GridViewDataSource.h"
#import "GridViewCell.h"

@implementation GridViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  
  if(self.source == nil) {
    return 0;
  }
  return self.source.rowCount * self.source.columnCount;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  // セルは常に再利用される。
  // 再利用キューにセルが1つもない場合、新規に作成されたセルが返される。
  // Reuse identifierを登録する必要がある
  GridViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GridViewCell kind]
                                                                 forIndexPath:indexPath];
  cell.colorProvider = self.colorProvider;
  NSInteger index = [indexPath indexAtPosition:1];
  NSInteger row = [self rowByIndex:index];
  NSInteger column = [self columnByIndex:index];
  if(row >= 0 && column >= 0) {
    NSString *value = [self.source valueAtRow:row atColumn:column];
    cell.text = value == nil ? @"" : value;
  }
  if([self.source respondsToSelector:@selector(activeAtRow:atColumn:)]) {
    if([self.source activeAtRow:row atColumn:column] ) {
      [cell setActived:YES];
    }
    else {
      [cell setActived:NO];
    }
  }

  return cell;
}

#pragma mark - Private

/*!
 Index番号から行番号
 */
- (NSInteger) rowByIndex:(NSInteger)index {
  
  NSInteger row =  floor(index / [self.source columnCount]);
  if(row > [self.source rowCount ]) {
    return -1;
  }
  return row;
}

/*!
 Index番号から列番号
 */
- (NSInteger) columnByIndex:(NSInteger)index {
  NSInteger column = index % [self.source columnCount];
  return column;
}


#pragma mark -

@end

@implementation GridRowHeaderDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  
  if(self.source == nil) {
    return 0;
  }
  return self.source.rowCount;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  
  return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  GridViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GridViewCell rowHeaderKind]
                                                                 forIndexPath:indexPath];
  cell.backgroundColor = [UIColor lightGrayColor];
  NSInteger index = [indexPath indexAtPosition:1];
  NSString *value;
  if([self.source respondsToSelector:@selector(rowTitleAt:)]) {
    value = [self.source rowTitleAt:index];
  }
  else {
    value = [NSString stringWithFormat:@"%d", index + 1];
  }

  cell.text = value == nil ? @"" : value;
  return cell;
}

@end

@implementation GridColumnHeaderDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  
  if(self.source == nil) {
    return 0;
  }
  return self.source.columnCount;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  GridViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GridViewCell columnHeaderKind]
                                                                 forIndexPath:indexPath];
  cell.backgroundColor = [UIColor lightGrayColor];
  NSInteger index = [indexPath indexAtPosition:1];
  NSString *value;
  if([self.source respondsToSelector:@selector(columnTitleAt:)]) {
    value = [self.source columnTitleAt:index];
  }
  else {
    value = [NSString stringWithFormat:@"%d", index + 1];
  }
  cell.text = value == nil ? @"" : value;
  return cell;
}

@end