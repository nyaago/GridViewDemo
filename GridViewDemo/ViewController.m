//
//  ViewController.m
//  GridViewDemo
//
//  Created by nyaago on 2013/10/02.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import "ViewController.h"
#import "GridDemoDataSource.h"
#import "GridViewDelegate.h"
#import "GridLayout.h"
#import "GridViewCell.h"


@interface ViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) GridViewDelegate *delegate;
@property (nonatomic, strong)   GridViewDataSource *viewDataSource;

@end

@implementation ViewController


- (void)viewDidLoad
{
  [super viewDidLoad];
  _viewDataSource = [[GridViewDataSource alloc] init];
  _viewDataSource.source = [[GridDemoDataSource alloc] init];
  GridLayout *layout = [[GridLayout alloc] init];
  layout.numberOfColumns = [_viewDataSource.source columnCount];
  CGRect frame = [self.view frame];
  _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
  _collectionView.dataSource = _viewDataSource;
  _delegate = [[GridViewDelegate alloc] init];
  _collectionView.delegate = _delegate;
  _collectionView.backgroundColor = [UIColor grayColor];
  _collectionView.directionalLockEnabled = NO;
  [_collectionView registerClass:[GridViewCell class] forCellWithReuseIdentifier:[GridViewCell kind]];
  self.view.backgroundColor = [UIColor grayColor];
  [self.view addSubview:_collectionView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  CGRect frame = self.view.bounds;
  _collectionView.frame = frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
