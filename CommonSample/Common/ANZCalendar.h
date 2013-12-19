//
//  ANZCalendar.h
//  CommonSample
//
//  Created by ANZ on 2013/12/12.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANZCalendar : UICollectionView <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) NSDate* displayDate;

- (id)initWithDisplayDate:(NSDate *)displayDate;
- (void)show;


- (void)dismiss;

@end
