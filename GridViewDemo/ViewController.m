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
#import "GridView.h"


@interface ViewController ()

@property (nonatomic, strong) GridView *gridView;
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
  _gridView = [[GridView alloc] initWithFrame:frame gridLayout:layout];
  _gridView.dataSource = _viewDataSource;
  _delegate = [[GridViewDelegate alloc] init];
  _gridView.delegate = _delegate;
  _gridView.backgroundColor = [UIColor grayColor];
  _gridView.directionalLockEnabled = NO;
  [_gridView registerClass:[GridViewCell class] forCellWithReuseIdentifier:[GridViewCell kind]];
  self.view.backgroundColor = [UIColor grayColor];
  [self.view addSubview:_gridView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  CGRect frame = self.view.bounds;
  _gridView.frame = frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
