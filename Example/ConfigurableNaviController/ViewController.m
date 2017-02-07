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
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [[btn1 titleLabel] setFont:[UIFont systemFontOfSize:13]];
    [btn1 setTitle:@"PushTransAnimStyle1" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    [btn1 setTag:100];
    [btn1 sizeToFit];
    btn1.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0 - btn1.bounds.size.height - 10);
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [[btn2 titleLabel] setFont:[UIFont systemFontOfSize:13]];
    [btn2 setTitle:@"PushTransAnimStyle2" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    [btn2 setTag:101];
    [btn2 sizeToFit];
    btn2.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0);
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [[btn3 titleLabel] setFont:[UIFont systemFontOfSize:13]];
    [btn3 setTitle:@"PushTransAnimStyle3" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    [btn3 setTag:102];
    [btn3 sizeToFit];
    
    btn3.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0 + btn2.bounds.size.height + 10);
}


- (void)clicked:(id)sender
{
    PushNextViewController *pushController = [[PushNextViewController alloc] init];
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithTitle:@"Exit" style:(UIBarButtonItemStylePlain) target:self action:@selector(onLeftBarItemClick:)];
    pushController.navigationItem.leftBarButtonItem = leftItem;
    
    ConfigurableNaviController *rootNav = [[ConfigurableNaviController alloc] initWithRootViewController:pushController defaultNavigationBarAppearance:^(UINavigationBar *navigationBar) {
        
        navigationBar.barTintColor = [UIColor greenColor];
        navigationBar.tintColor = [UIColor blueColor];
        
    }];
    rootNav.transAnimStyle = [sender tag] - 100;
    
    
    [self presentViewController:rootNav animated:YES completion:^{
        
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
