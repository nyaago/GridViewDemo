//
//  ViewController.h
//  GridViewDemo
//
//  Created by nyaago on 2013/10/02.
//  Copyright (c) 2013年 nyaago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridViewDataSource.h"


@interface GridViewController : UIViewController {

NSObject<GridDataSource> *_source;
}

- (id)initWithFrame:(CGRect)frame;

@property (nonatomic) NSObject<GridDataSource> *source;

@end
