//
//  ViewController.h
//  GridViewDemo
//
//  Created by nyaago on 2013/10/02.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridViewDataSource.h"


@interface GridViewController : UIViewController <UICollectionViewDelegate> {

NSObject<GridDataSource> *_source;
}


@property (nonatomic) NSObject<GridDataSource> *source;
@property (nonatomic) BOOL allowsMultipleSelection;
@property (nonatomic) BOOL allowsSelection;
@end
