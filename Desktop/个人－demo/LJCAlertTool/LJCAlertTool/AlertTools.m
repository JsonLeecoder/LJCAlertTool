//
//  AlertTools.m
//  LJCAlertTool
//
//  Created by jiachen on 17/1/9.
//  Copyright © 2017年 jiachen. All rights reserved.
//

#import "AlertTools.h"
#import <CoreLocation/CoreLocation.h>
#import "UIAlertView+Block.h"
@interface AlertTools()<UIAlertViewDelegate>

@end

@implementation AlertTools


+ (void)showTipAlertViewWith:(UIViewController *)viewController
                                        title:(NSString *)title
                                message:(NSString *)message
                             buttonTitle:(NSString *)btnTitle
                            buttonStyle:(AlertStyle)btnStyle
{
        if (iOS_Version >= 8.0)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            
            //添加按钮
        
            UIAlertAction *singleActionDefault = nil;
            
            UIAlertAction *singleActionCancel  = nil;

            singleActionDefault = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self openURLWithbuttonStyle:btnStyle];
            }];
            [alertController addAction:singleActionDefault];
            
            singleActionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
            }];
            [alertController addAction:singleActionCancel];

 
            [viewController presentViewController:alertController animated:YES completion:nil];
            
        }
        else
        {            
            switch (btnStyle) {
                case AlertLocated:
                    [self locatedAlertView];
                    break;
                case AlertTelephont:
                    [self telephontAlertView];
                    break;
                case AlertNetWork:
                    [self netWorkAlertView];
                    break;
                    
                default://默认的
                    break;
            
        }
    }
}


+ (void)openURLWithbuttonStyle:(AlertStyle)btnStyle{
    NSURL *url = nil;
    if (btnStyle == AlertLocated) {
//        if (iOS_Version >= 7.0 && [CLLocationManager locationServicesEnabled])
//        {
//            url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//        }
//        else
//        {
            url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
//        }
    }
    if (btnStyle == AlertTelephont) {
            url = [NSURL URLWithString:@"tel://123456"];
    }
    if (btnStyle == AlertNetWork) {
        if(iOS_Version < 10)
        {
            url = [NSURL URLWithString:@"prefs:root=MOBILE_DATA_SETTINGS_ID"];
        }
        else{
            url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        }
    }
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:url];
        });
    }
}

/*!
 @brief 拨打客服电话
 */
+ (void)telephontAlertView{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"每天07:30-20:00,\n竭诚为您服务" message:nil cancelButtonTitle:@"取消" otherButtonTitle:@"确认拨打"];
    
    [alertView showUsingBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://123456"]];
        }
    }];
}
/*!
 @brief KA拨打客服电话
 */
//+ (void)KA_TelephontAlertView{
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"每天07:30-20:00,\n竭诚为您服务" message:nil cancelButtonTitle:@"取消" otherButtonTitle:@"确认拨打"];
//    
//    [alertView showUsingBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
//        if (buttonIndex == 1) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://0571-83826315"]];
//        }
//    }];
//}
/*!
 @brief 提示开启定位权限
 */
+ (void)netWorkAlertView{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"检测到网络未打开" message:@"请确保移动网络或wifi处于打开状态" cancelButtonTitle:@"取消" otherButtonTitle:@"设置"];
    
    [alertView showUsingBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if(buttonIndex == 1)
        {
            if(iOS_Version < 10)
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=MOBILE_DATA_SETTINGS_ID"]];
            }
            else{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
        }
    }];
}

+ (void )locatedAlertView{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"允许定位开关" message:@"应用未获取定位服务授权，请进入系统[设置]>[隐私]>[定位服务]中打开开关，并允许使用定位服务" cancelButtonTitle:@"取消" otherButtonTitle:@"设置"];
    
    [alertView showUsingBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if(buttonIndex == 1)
        {
            NSURL *url = nil;
            if (iOS_Version >= 7.0 && [CLLocationManager locationServicesEnabled])
            {
                url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            }
            else
            {
                url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
            }
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }];

}




@end
