//
//  ItemGridViewController.h
//  GridViewDemo
//
//  Created by nyaago on 2013/10/10.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridViewDataSource.h"
#import "GridView.h"


@interface ItemGridViewController : UIViewController <GridViewGestureDelegate, UICollectionViewDelegate>  {

NSObject<GridDataSource> *_source;
}

//- (id)initWithFrame:(CGRect)frame;

@property (nonatomic) NSObject<GridDataSource> *source;
@property (nonatomic) CGFloat minScale;
@property (nonatomic) CGFloat maxScale;
@property (nonatomic) BOOL allowsMultipleSelection;
@property (nonatomic) BOOL allowsSelection;
@property (nonatomic) BOOL allowsRowSelection;
@property (nonatomic) BOOL allowsColumnSelection;
@property (nonatomic) BOOL autosizing;
@property (nonatomic) CGFloat contentsTop;

- (void) clearSelection;


@end
