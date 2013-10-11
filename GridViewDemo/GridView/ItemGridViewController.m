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
@property (nonatomic) CGFloat contentsTop;

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

  self.view.backgroundColor = [UIColor grayColor];
  _gridView.allowsSelection = YES;

  [self.view addSubview:_columnHeaderGridView];
  [self.view addSubview:_rowHeaderGridView];
  [self.view addSubview:_gridView];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  _gridView.frame = self.gridViewFrame;
  _gridView.allowsMultipleSelection = self.allowsMultipleSelection;
  _gridView.allowsSelection = self.allowsSelection;
  _rowHeaderGridView.frame = self.rowHeaderViewFrame;
  _columnHeaderGridView.frame = self.columnHeaderViewFrame;
  
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  _gridView.frame = self.gridViewFrame;
  _gridView.allowsMultipleSelection = self.allowsMultipleSelection;
  _gridView.allowsSelection = self.allowsSelection;
  _rowHeaderGridView.frame = self.rowHeaderViewFrame;
  _columnHeaderGridView.frame = self.columnHeaderViewFrame;
}

- (void) viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
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
  NSInteger i = [indexPath indexAtPosition:1];
  NSLog(@"cell %d is selected", i);
}

- (BOOL)collectionView:(UICollectionView *)collectionView
shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

- (void)collectionView:(UICollectionView *)collectionView
didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger i = [indexPath indexAtPosition:1];
  NSLog(@"cell %d is deselected", i);
  
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
  return CGSizeMake(self.view.frame.size.width - self.scaledRowHeaderWidth,
                    self.view.frame.size.height - self.scaledColumnHeaderHeight - self.contentsTop);
}

- (CGRect) gridViewFrame {
  return CGRectMake(self.scaledRowHeaderWidth,
                    self.scaledColumnHeaderHeight + self.contentsTop,
                    self.scaledGridViewSize.width,
                    self.scaledGridViewSize.height);
}

- (CGRect) rowHeaderViewFrame {
  return CGRectMake(0.0f, self.scaledColumnHeaderHeight + self.contentsTop ,
                    self.scaledRowHeaderWidth, self.scaledGridViewSize.height);
}

- (CGRect) columnHeaderViewFrame {
  return CGRectMake(self.scaledRowHeaderWidth,
                    0.0f ,
                    self.scaledGridViewSize.width,
                    self.scaledColumnHeaderHeight +  self.contentsTop);
}

- (CGFloat) contentsTop {

  if(_contentsTop == 0.0f) {
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    _contentsTop = (frame.origin.y > frame.origin.x ?  frame.origin.y : frame.origin.x);
    if(self.navigationController.navigationBarHidden == NO) {
      _contentsTop += self.navigationController.navigationBar.frame.size.height;
    }
  }
  return _contentsTop;
}

// GridViewを生成
- (void)createGridView  {
  _viewDataSource = [[GridViewDataSource alloc] init];
  _viewDataSource.source = self.source;

  GridLayout *layout = [[GridLayout alloc] init];
  layout.numberOfColumns = [_viewDataSource.source columnCount];
  layout.itemSize = self.scaledCellSize;
  _gridView = [[GridView alloc] initWithFrame:self.gridViewFrame gridLayout:layout];
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


@end
