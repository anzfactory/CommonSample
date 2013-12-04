//
//  ANZPickerView.m
//  golfdiary
//
//  Created by ANZ on 2013/11/19.
//
//

#import "ANZPickerView.h"

@implementation ANZPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    return;
//    
//    // Drawing code
//    @autoreleasepool {
//        
//        CGFloat red;
//        CGFloat green;
//        CGFloat blue;
//        CGFloat alpha;
//        
//        if (! [self.backgroundColor getRed:&red green:&green blue:&blue alpha:&alpha]) {
//            return;
//        }
//        
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        CGContextSetRGBFillColor(context, red, green, blue, alpha);
//        CGRect r1 = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//        CGContextAddRect(context,r1);
//        CGContextFillPath(context);
//    }
//}


@end
