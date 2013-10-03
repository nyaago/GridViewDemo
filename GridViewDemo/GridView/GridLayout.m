//
//  GridLayout.m
//  GridViewDemo
//
//  Created by nyaago on 2013/10/02.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import "GridLayout.h"
#import "GridViewCell.h"
#import "GridViewLayoutAttribute.h"

@interface GridLayout()

@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, strong) NSMutableArray *itemFrames;


@end

@implementation GridLayout


- (id)init
{
  self = [super init];
  if (self)
  {
    // set default value to properties.
    self.itemSize = (CGSize){100, 25};
    self.itemSpacing = 1;
    self.lineSpacing = 1;
    self.numberOfColumns = 10;
    self.contentSize = CGSizeZero;
    
  }
  return self;
}

#pragma mark - UICollectionViewLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
  return NO;
}

- (CGSize)collectionViewContentSize {
  
  return self.contentSize;
}

- (void)prepareLayout
{
  [super prepareLayout];
  
  [self prepareItemsLayout];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
  
  // NSLog(@"layoutAttributesForElementsInRect x / y - %f / %f", rect.origin.x, rect.origin.y);
  NSMutableArray *attributesArray = [NSMutableArray array];
  NSInteger numOfItems = [self.collectionView numberOfItemsInSection:0];
  for (NSInteger item = 0; item < numOfItems; item++) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
    UICollectionViewLayoutAttributes *cellAttributes
    = [self layoutAttributesForItemAtIndexPath:indexPath];
    //CGRect cellRect = cellAttributes.frame;
    if (CGRectIntersectsRect(rect, cellAttributes.frame)) {
      [attributesArray addObject:cellAttributes];
    }
  }
  return attributesArray;
  
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path {
  NSInteger index = [path indexAtPosition:1];
  CGRect itemFrame = [[self.itemFrames objectAtIndex:index] CGRectValue];
  GridViewLayoutAttribute *attributes
  = [GridViewLayoutAttribute layoutAttributesForCellWithIndexPath:path];
  attributes.size = self.itemSize;
  attributes.center = CGPointMake(CGRectGetMidX(itemFrame), CGRectGetMidY(itemFrame));
  return attributes;
}

#pragma mark - Properties

// ピンチジェスチャーに対応
// また、変化があった場合、常にレイアウトが更新されるようにする
- (void)setPinchPoint:(CGPoint)pinchPoint {
  
  _pinchPoint = pinchPoint;
  [self invalidateLayout];
}

- (void)setPinchScale:(CGFloat)pinchScale {
  
  _pinchScale = pinchScale;
  [self invalidateLayout];
}

#pragma mark - Private

- (void)prepareItemsLayout
{
  self.itemFrames = [NSMutableArray array];
  
  int numberOfItems = [self.collectionView numberOfItemsInSection:0];
  CGFloat availableWidth = self.itemSize.width;
  CGFloat availableHeight = self.itemSize.height;
  for (int item = 0; item < numberOfItems; item++)
  {
    int column = item % self.numberOfColumns;
    int row = floor(item / self.numberOfColumns);
    CGFloat left = (availableWidth + self.itemSpacing * 2) * column;
    CGFloat top = (availableHeight + self.lineSpacing * 2) * row;

    
    CGRect itemFrame = (CGRect){{left, top + self.collectionView.contentOffset.y}, self.itemSize};
    [self.itemFrames addObject:[NSValue valueWithCGRect:itemFrame]];
    
  }
  
  int numberOfItemRows = floor(numberOfItems / self.numberOfColumns);
  self.contentSize = CGSizeMake((availableWidth + self.itemSpacing * 2) * self.numberOfColumns,
                                (availableHeight + self.lineSpacing * 2) * numberOfItemRows);
}

@end
