//
//  ItemGridViewController.m
//  GridViewDemo
//
//  Created by nyaago on 2013/10/10.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import "ItemGridViewController.h"
#import "GridViewDelegate.h"
#import "GridLayout.h"
#import "GridViewCell.h"
#import "GridView.h"

@interface ItemGridViewController ()

@property (nonatomic, strong) GridView *gridView;
@property (nonatomic, strong) GridView *rowHeaderGridView;
@property (nonatomic, strong) GridView *columnHeaderGridView;
@property (nonatomic, strong) GridViewDelegate *delegate;
@property (nonatomic, strong)   GridViewDataSource *viewDataSource;
@property (nonatomic, strong)   GridRowHeaderDataSource *rowHeaderDataSource;
@property (nonatomic, strong)   GridColumnHeaderDataSource *columnHeaderDataSource;

@property (nonatomic, strong) UIPinchGestureRecognizer *pinchGestureRecognizer;

@property (nonatomic) CGFloat scale;
@property (nonatomic) CGFloat columnHeaderHeight;
@property (nonatomic) CGFloat rowHeaderWidth;
@property (nonatomic) CGSize cellSize;

//@property (nonatomic) CGRect frame;

/** 
 * view の Frameの計算
 */
- (CGRect) contentsFrame;

/**
 * status bar の高さ
 */
- (CGFloat) statusBarHeight;

/*
 * 各Sub Viewの frame設定
 */
- (void) setFrameOfViews;

@end

@implementation ItemGridViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      [self setDefault];
      [self initProperties];
    }
    return self;
}

- (id)init  {
  self = [super init];
  if(self) {
    [self setDefault];
    [self initProperties];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self createGridView];
  [self createColumnHeaderView];
  [self createRowHeaderView];
  self.view.autoresizesSubviews = NO;

  self.view.backgroundColor = [UIColor grayColor];
  _gridView.allowsSelection = YES;

  [self.view addSubview:_columnHeaderGridView];
  [self.view addSubview:_rowHeaderGridView];
  [self.view addSubview:_gridView];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self setFrameOfViews];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
}

- (void) viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  [self setFrameOfViews];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  
  [self setFrameOfViews];
}

#pragma mark - Public Methods

- (void) clearSelection {
  NSInteger count = [self.source columnCount] * [self.source rowCount];
  for(int i = 0; i < count; ++i) {
    [self.gridView deselectItemAtIndexPath:[NSIndexPath
                                          indexPathForItem:i inSection:0]
                                  animated:YES];
  }
  for(int i = 0; i < [self.source columnCount]; ++i) {
    [self.columnHeaderGridView deselectItemAtIndexPath:[NSIndexPath
                                                        indexPathForItem:i inSection:0]
                                              animated:NO];
  }
  for(int i = 0; i < [self.source rowCount]; ++i) {
    [self.rowHeaderGridView deselectItemAtIndexPath:[NSIndexPath
                                                     indexPathForItem:i inSection:0]
                                           animated:NO];
  }
}


#pragma mark Properties

- (void) setMaxScale:(CGFloat)maxScale {
  _maxScale = maxScale;
  _gridView.layout.maxScale = _maxScale;
  _rowHeaderGridView.layout.maxScale = maxScale;
  _columnHeaderGridView.layout.maxScale = maxScale;
}

- (void) setMinScale:(CGFloat)minScale {
  _minScale = minScale;
  _gridView.layout.minScale = _minScale;
  _rowHeaderGridView.layout.minScale  = minScale;
  _columnHeaderGridView.layout.minScale = minScale;
}


#pragma mark GridViewGestureDelegate

- (void) gridView:(GridView *)view pinchGestured:(UIPinchGestureRecognizer *)gestureRecognizer {
  CGFloat scale = [gestureRecognizer scale];
  NSLog(@"pinch - scale = %f", scale);
  CGFloat newScale = self.scale * scale;
  if(newScale >= self.maxScale) {
    self.scale = self.maxScale;
  }
  else if(newScale <= self.minScale) {
    self.scale = self.minScale;
  }
  else {
    self.scale = newScale;
  }
  self.gridView.layout.scale = self.scale;
  self.rowHeaderGridView.layout.scale = self.scale;
  self.columnHeaderGridView.layout.scale = self.scale;
  self.gridView.frame = [self gridViewFrame];
  self.rowHeaderGridView.frame = [self rowHeaderViewFrame];
  self.columnHeaderGridView.frame = [self columnHeaderViewFrame];
  
  [self.view setNeedsDisplay];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if(scrollView == self.gridView) {
    CGPoint p = scrollView.contentOffset;
    p.x = 0.0f;
    self.rowHeaderGridView.contentOffset = p;
    p = scrollView.contentOffset;
    p.y = self.columnHeaderGridView.contentOffset.y;
    self.columnHeaderGridView.contentOffset = p;
  }
  else if(scrollView == self.rowHeaderGridView) {
    CGPoint p = self.gridView.contentOffset;
    p.y = self.rowHeaderGridView.contentOffset.y;
    self.gridView.contentOffset = p;
  }
  else if(scrollView == self.columnHeaderGridView) {
    CGPoint p = self.gridView.contentOffset;
    p.x = self.columnHeaderGridView.contentOffset.x;
    self.gridView.contentOffset = p;
  }
}

#pragma mark UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView
shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  
  return YES;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger index = [indexPath indexAtPosition:1];
  NSLog(@"cell %d is selected", index);
  NSInteger columnCount = [self.source columnCount];
  if(collectionView == self.columnHeaderGridView) {
  for(int i = index % columnCount;
      i < self.source.columnCount * self.source.rowCount;
      i+=columnCount) {
    [self.gridView selectItemAtIndexPath:[NSIndexPath
                                          indexPathForItem:i inSection:0]
                                animated:YES
                          scrollPosition:UICollectionViewScrollPositionNone];
    }
  }
  else if(collectionView == self.rowHeaderGridView) {
    for(int i = index * columnCount; i < index * columnCount + columnCount; ++i) {
      [self.gridView selectItemAtIndexPath:[NSIndexPath
                                            indexPathForItem:i inSection:0]
                                  animated:YES
                            scrollPosition:UICollectionViewScrollPositionNone];
    }
  }
}

- (BOOL)collectionView:(UICollectionView *)collectionView
shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

- (void)collectionView:(UICollectionView *)collectionView
didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger index = [indexPath indexAtPosition:1];
  NSLog(@"cell %d is selected", index);
  NSInteger columnCount = [self.source columnCount];
  if(collectionView == self.columnHeaderGridView) {
    for(int i = index % columnCount; i < self.source.columnCount * self.source.rowCount; i+=columnCount) {
      [self.gridView deselectItemAtIndexPath:[NSIndexPath
                                            indexPathForItem:i inSection:0]
                                  animated:YES];

      GridViewCell *cell = (GridViewCell *)[self.gridView
                                            cellForItemAtIndexPath:[NSIndexPath
                                                                    indexPathForItem:i inSection:0]];
      [cell setSelected:NO];
      
    }
  }
  else if(collectionView == self.rowHeaderGridView) {
    for(int i = index * columnCount; i < index * columnCount + columnCount; ++i) {
      GridViewCell *cell = (GridViewCell *)[self.gridView
                                            cellForItemAtIndexPath:[NSIndexPath
                                                                    indexPathForItem:i inSection:0]];
      [cell setSelected:NO];
    }
  }
 
}

/*
 - (BOOL)collectionView:(UICollectionView *)collectionView
 shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */


#pragma mark Private

- (void) setDefault {
  self.columnHeaderHeight = 25.0f;
  self.rowHeaderWidth = 50.0f;
  self.cellSize = CGSizeMake(60.0f, 25.0f);
  self.scale = 1.0f;
  self.maxScale = 1.5f;
  self.minScale = 0.8f;
  self.autosizing = YES;
  self.contentsTop = 0;
}

- (void) initProperties {
}


- (CGFloat) scaledRowHeaderWidth {
  return _rowHeaderWidth * self.scale;
}

- (CGFloat) scaledColumnHeaderHeight {
  return _columnHeaderHeight * self.scale;
}

- (CGSize) scaledCellSize {
  return CGSizeMake(self.cellSize.width * self.scale,
                    self.cellSize.height * self.scale);
}

- (CGSize) scaledRowHeaderCellSize {
  return CGSizeMake(self.scaledRowHeaderWidth, self.scaledCellSize.height);
}

- (CGSize) scaledColumnHeaderCellSize {
  return CGSizeMake(self.scaledCellSize.width, self.scaledColumnHeaderHeight);
}

- (CGSize) scaledGridViewSize {
  return CGSizeMake([self contentsFrame].size.width - self.scaledRowHeaderWidth,
                    [self contentsFrame].size.height - self.scaledColumnHeaderHeight
 );
}

- (CGRect) gridViewFrame {
    CGRect  frame= CGRectMake(self.scaledRowHeaderWidth,
                    self.scaledColumnHeaderHeight + self.contentsTop,
                    self.scaledGridViewSize.width,
                    self.scaledGridViewSize.height);
  return frame;
}

- (CGRect) rowHeaderViewFrame {
  return CGRectMake(0.0f, self.scaledColumnHeaderHeight + self.contentsTop ,
                    self.scaledRowHeaderWidth, self.scaledGridViewSize.height);
}

- (CGRect) columnHeaderViewFrame {
  //NSLog(@"height = %f", self.scaledColumnHeaderHeight + self.contentsTop - 10);
  // @TODO - ??
  CGFloat offset = 0;
  offset = [self statusBarHeight];
  if(self.navigationController.navigationBarHidden == NO) {
    offset += self.navigationController.navigationBar.frame.size.height;
  }
  return CGRectMake(self.scaledRowHeaderWidth,
                    0.0f  ,
                    self.scaledGridViewSize.width,
                    self.scaledColumnHeaderHeight + self.contentsTop );
}

- (CGFloat) contentsTop {
  CGRect frame = [self contentsFrame];
  _contentsTop = frame.origin.y;
  //NSLog(@"contents top = %f", _contentsTop);
  return _contentsTop;
}

- (CGRect) viewFrame {
  
  CGRect frame = self.view.frame;
  CGRect screenFrame = [[UIScreen mainScreen] bounds];
  if(self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
     self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
    frame.size.height = screenFrame.size.width;
    frame.size.width = screenFrame.size.height;
    frame.origin.y = screenFrame.origin.x;
    frame.origin.x = screenFrame.origin.y;
  }
  else {
    frame = screenFrame;
  }
  return frame;
}

- (CGRect) contentsFrame {
  
  CGRect frame = self.view.frame;
  CGRect screenFrame = [[UIScreen mainScreen] applicationFrame];
  if(self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
     self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
    frame.size.height = screenFrame.size.width;
    frame.size.width = screenFrame.size.height;
    frame.origin.y = screenFrame.origin.x;
    frame.origin.x = screenFrame.origin.y;
  }
  else {
    frame = screenFrame;
  }

  if(self.navigationController.navigationBarHidden == NO) {
    frame.origin.y += self.navigationController.navigationBar.frame.size.height;
    frame.size.height -= self.navigationController.navigationBar.frame.size.height;
  }
  if(self.navigationController.tabBarController &&
     self.navigationController.tabBarController.tabBar &&
     self.navigationController.tabBarController.tabBar.hidden == NO) {
    frame.size.height -= self.navigationController.tabBarController.tabBar.frame.size.height;
  }
  if(self.navigationController.toolbarHidden == NO) {
    frame.size.height -= self.navigationController.toolbar.frame.size.height;
  }
  return frame;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
              selected:(BOOL)selected {
  NSInteger index = [indexPath indexAtPosition:1];
  NSLog(@"cell %d is selected", index);
  NSInteger columnCount = [self.source columnCount];
  if(collectionView == self.columnHeaderGridView) {
    for(int i = index % columnCount; i < self.source.columnCount * self.source.rowCount; i+=columnCount) {
      GridViewCell *cell = (GridViewCell *)[self.gridView
                                            cellForItemAtIndexPath:[NSIndexPath
                                                                    indexPathForItem:i inSection:0]];
      [cell setSelected:selected];
      
    }
  }
  else if(collectionView == self.rowHeaderGridView) {
    for(int i = index * columnCount; i < index * columnCount + columnCount; ++i) {
      GridViewCell *cell = (GridViewCell *)[self.gridView
                                            cellForItemAtIndexPath:[NSIndexPath
                                                                    indexPathForItem:i inSection:0]];
      [cell setSelected:selected];
    }
  }

}

// GridViewを生成
- (void)createGridView  {
  _viewDataSource = [[GridViewDataSource alloc] init];
  _viewDataSource.source = self.source;

  GridLayout *layout = [[GridLayout alloc] init];
  layout.numberOfColumns = [_viewDataSource.source columnCount];
  layout.itemSize = self.scaledCellSize;
  _gridView = [[GridView alloc] initWithFrame:self.gridViewFrame
                                   gridLayout:layout];
  _gridView.alwaysBounceVertical = NO;
  _gridView.alwaysBounceHorizontal = NO;
  _gridView.bounces = NO;
  _gridView.gestureDelegate = self;
  _gridView.dataSource = _viewDataSource;
  _delegate = [[GridViewDelegate alloc] init];
  _gridView.delegate = self;
  _gridView.backgroundColor = [UIColor blackColor];
  _gridView.directionalLockEnabled = NO;
  [_gridView registerClass:[GridViewCell class] forCellWithReuseIdentifier:[GridViewCell kind]];
}

// 行ヘッダー部分を生成
- (void) createRowHeaderView {
  _rowHeaderDataSource = [[GridRowHeaderDataSource alloc] init];
  _rowHeaderDataSource.source = self.source;
  GridLayout *layout = [[GridLayout alloc] init];
  layout.itemSize = self.scaledRowHeaderCellSize;
  layout.numberOfColumns = 1;
  _rowHeaderGridView = [[GridView alloc] initWithFrame:self.rowHeaderViewFrame
                                            gridLayout:layout];
  _rowHeaderGridView.bounces = NO;
  _rowHeaderGridView.alwaysBounceHorizontal = NO;
  _rowHeaderGridView.alwaysBounceVertical = NO;
  _rowHeaderGridView.gestureDelegate = self;
  _rowHeaderGridView.delegate = self;
  _rowHeaderGridView.dataSource = _rowHeaderDataSource;
  _rowHeaderGridView.backgroundColor = [UIColor grayColor];
  _rowHeaderGridView.directionalLockEnabled = NO;
  [_rowHeaderGridView registerClass:[GridViewCell class]
         forCellWithReuseIdentifier:[GridViewCell rowHeaderKind]];
}

// 行ヘッダー部分を生成
- (void) createColumnHeaderView {
  _columnHeaderDataSource = [[GridColumnHeaderDataSource alloc] init];
  _columnHeaderDataSource.source = self.source;
  
  GridLayout *layout = [[GridLayout alloc] init];
  layout.itemSize = self.scaledColumnHeaderCellSize;
  layout.numberOfColumns = [_viewDataSource.source columnCount];
  _columnHeaderGridView = [[GridView alloc] initWithFrame:self.columnHeaderViewFrame
                                               gridLayout:layout];
  _columnHeaderGridView.bounces = NO;
  _columnHeaderGridView.alwaysBounceVertical = NO;
  _columnHeaderGridView.alwaysBounceHorizontal = NO;
  _columnHeaderGridView.delegate = self;
  _columnHeaderGridView.dataSource = _columnHeaderDataSource;
  _columnHeaderGridView.backgroundColor = [UIColor grayColor];
  _columnHeaderGridView.directionalLockEnabled = NO;
  [_columnHeaderGridView registerClass:[GridViewCell class]
         forCellWithReuseIdentifier:[GridViewCell columnHeaderKind]];
}

- (CGFloat) statusBarHeight {
  CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
  return MIN(statusBarSize.width, statusBarSize.height);
}

- (void) setFrameOfViews {
  
  _gridView.frame = self.gridViewFrame;
  _gridView.allowsMultipleSelection = self.allowsMultipleSelection;
  _gridView.allowsSelection = self.allowsSelection;
  _columnHeaderGridView.allowsSelection = self.allowsColumnSelection;
  _columnHeaderGridView.allowsMultipleSelection = self.allowsMultipleSelection;
  _rowHeaderGridView.allowsSelection = self.allowsMultipleSelection;
  _rowHeaderGridView.allowsMultipleSelection = self.allowsMultipleSelection;
  
  _rowHeaderGridView.frame = self.rowHeaderViewFrame;
  _columnHeaderGridView.frame = self.columnHeaderViewFrame;
  // }
  if(self.navigationController.toolbarHidden == NO) {
    CGRect barFrame = self.navigationController.toolbar.frame;
    CGRect viewFrame =[self viewFrame];
    barFrame.origin.y = viewFrame.size.height - barFrame.size.height;
    self.navigationController.toolbar.frame = barFrame;
  }

}

@end
