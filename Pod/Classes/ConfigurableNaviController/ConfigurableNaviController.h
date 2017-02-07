//
//  ConfigurableNaviController.h
//  ConfigurableNavigation
//
//  Created by hncoder on 2017/2/5.
//  Copyright © 2017年 hncoder. All rights reserved.
//

#import <UIKit/UIKit.h>

// It supports three transitioning animation style
typedef NS_ENUM(NSUInteger, ConfigurableTransAnimStyle)
{
    ConfigurableTransAnimStyle1,
    ConfigurableTransAnimStyle2,
    ConfigurableTransAnimStyle3,
    ConfigurableTransAnimStyleDefault = ConfigurableTransAnimStyle1,
};

@protocol ConfigurableNavigationControllerDelegate <NSObject>

@optional

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end

@interface ConfigurableNaviController : UINavigationController
// Don't set `delegate`, use `proxyDelegate` instead.
@property (nonatomic, weak) id<ConfigurableNavigationControllerDelegate> proxyDelegate;
// Set the transitioning animation style, `ConfigurableTransAnimStyle1` is default style.
@property (nonatomic, assign) ConfigurableTransAnimStyle transAnimStyle;
@end

@interface UIViewController(ConfigurableNaviController)
// Get the proxy navigation controller, it's the real navigation controller to push view controllers.
- (ConfigurableNaviController *)proxyNavigationController;

@end
