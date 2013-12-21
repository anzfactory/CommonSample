//
//  ANZCalendarCell.h
//  CommonSample
//
//  Created by ANZ on 2013/12/13.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANZCalendarDataObject.h"

@interface ANZCalendarCell : UICollectionViewCell

@property (nonatomic) ANZCalendarDataObject* data;
@property (nonatomic) UIColor* lineColor;

@end
