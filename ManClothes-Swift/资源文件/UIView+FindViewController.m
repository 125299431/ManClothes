//
//  UIView+FindViewController.m
//
//  Created by imac on 15/8/18.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "UIView+FindViewController.h"

@implementation UIView (FindViewController)
- (UIViewController *)viewController
{
    UIResponder *next = self.nextResponder;
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    } while (next);
    return nil;
}
@end
