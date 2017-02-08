//
//  ViewController.m
//  ConfigurableNaviController
//
//  Created by hncoder on 2017/2/7.
//  Copyright © 2017年 hncoder. All rights reserved.
//

#import "ViewController.h"
#import "PushNextViewController.h"
#import "ConfigurableNaviController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [[btn titleLabel] setFont:[UIFont systemFontOfSize:13]];
    [btn setTitle:@"PushTransAnimStylesDemo" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn sizeToFit];
    btn.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0);
}

- (UINavigationController *)navigationControllerWithTitle:(NSString *)title pushAnimStyle:(ConfigurableTransAnimStyle)style
{
    PushNextViewController *pushController = [[PushNextViewController alloc] init];
    
    ConfigurableNaviController *rootNav = [[ConfigurableNaviController alloc] initWithRootViewController:pushController defaultNavigationBarAppearance:^(UINavigationBar *navigationBar) {
        
        navigationBar.barTintColor = [UIColor greenColor];
        navigationBar.tintColor = [UIColor blueColor];
        
    }];
    rootNav.transAnimStyle = style;
    
    rootNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:nil selectedImage:nil];
    
    
    return rootNav;
}

- (void)clicked:(id)sender
{

    UINavigationController *pushAnim1Navi = [self navigationControllerWithTitle:@"PushTransAnimStyle1" pushAnimStyle:ConfigurableTransAnimStyle1];
    UINavigationController *pushAnim2Navi = [self navigationControllerWithTitle:@"PushTransAnimStyle2" pushAnimStyle:ConfigurableTransAnimStyle2];
    UINavigationController *pushAnim3Navi = [self navigationControllerWithTitle:@"PushTransAnimStyle3" pushAnimStyle:ConfigurableTransAnimStyle3];
    
    UITabBarController *barController = [[UITabBarController alloc] init];
    barController.viewControllers = @[pushAnim1Navi,pushAnim2Navi,pushAnim3Navi];
    
    [self presentViewController:barController animated:YES completion:^{
        
    }];
}

- (void)onLeftBarItemClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
