//
//  ViewController.m
//  GridViewDemo
//
//  Created by nyaago on 2013/10/02.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import "GridViewController.h"
#import "GridViewDelegate.h"
#import "GridLayout.h"
#import "GridViewCell.h"
#import "GridView.h"


@interface GridViewController ()

@property (nonatomic, strong) GridView *gridView;
@property (nonatomic, strong) GridViewDelegate *delegate;
@property (nonatomic, strong)   GridViewDataSource *viewDataSource;

@end

@implementation GridViewController


- (void)viewDidLoad
{
  [super viewDidLoad];
  _viewDataSource = [[GridViewDataSource alloc] init];
  _viewDataSource.source = self.source;
  GridLayout *layout = [[GridLayout alloc] init];
  layout.numberOfColumns = [_viewDataSource.source columnCount];
  CGRect frame = [self.view frame];
//  frame.origin.y = 0;
  _gridView = [[GridView alloc] initWithFrame:frame gridLayout:layout];
  _gridView.dataSource = _viewDataSource;
  _delegate = [[GridViewDelegate alloc] init];
  _gridView.delegate = _delegate;
  _gridView.backgroundColor = [UIColor grayColor];
  _gridView.directionalLockEnabled = NO;
  [_gridView registerClass:[GridViewCell class] forCellWithReuseIdentifier:[GridViewCell kind]];
  self.view.backgroundColor = [UIColor grayColor];
  [self.view addSubview:_gridView];
}

- (void) viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  CGRect frame = self.view.bounds;
  _gridView.frame = frame;
}

- (void) viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  CGRect frame = self.view.bounds;
  _gridView.frame = frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Properties


- (void)setSource:(NSObject<GridDataSource> *)source {
  _source = source;
  if(_viewDataSource) {
    _viewDataSource.source = source;
  }
}

- (NSObject<GridDataSource> *)source {
  return _source;
}



@end
