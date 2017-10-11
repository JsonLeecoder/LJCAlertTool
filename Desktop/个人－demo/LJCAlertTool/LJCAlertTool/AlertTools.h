//
//  AlertTools.h
//  LJCAlertTool
//
//  Created by jiachen on 17/1/9.
//  Copyright © 2017年 jiachen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 *  回调block
 */
typedef void(^AlertToolsBlock) (void);

/**
 *
 */
typedef enum {
    AlertLocated = 0,
    AlertTelephont,
    AlertNetWork,
}AlertStyle;

@interface AlertTools : NSObject

/**
 *  检测系统版本
 */
#define iOS_Version [[[UIDevice currentDevice] systemVersion] doubleValue]

/**
 *  空白标题，如果title直接设置为nil，那么message设置的内容直接被上移为title，message无效，字体就是加粗的样式
 */
#define EmptyTitle iOS_Version >= 7.0 ? @"" : @" "


+ (void)showTipAlertViewWith:(UIViewController *)viewController
                       title:(NSString *)title
                     message:(NSString *)message
                 buttonTitle:(NSString *)btnTitle
                 buttonStyle:(AlertStyle)btnStyle;


@end
