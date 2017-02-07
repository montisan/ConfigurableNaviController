//
//  ConfigurableNaviController.h
//  ConfigurableNavigation
//
//  Created by hncoder on 2017/2/5.
//  Copyright © 2017年 hncoder. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ConfigurableTransAnimStyle)
{
    ConfigurableTransAnimStyle1,
    ConfigurableTransAnimStyle2,
    ConfigurableTransAnimStyle3,
    ConfigurableTransAnimStyleDefault = ConfigurableTransAnimStyle1,
};

@interface ConfigurableNaviController : UINavigationController

@property (nonatomic, weak) id<UINavigationControllerDelegate> proxyDelegate;
@property (nonatomic, assign) ConfigurableTransAnimStyle transAnimStyle; // The default style is `ConfigurableTransAnimStyleDefault`.

@end

@interface UIViewController(ConfigurableNaviController)

- (ConfigurableNaviController *)proxyNavigationController;

@end
