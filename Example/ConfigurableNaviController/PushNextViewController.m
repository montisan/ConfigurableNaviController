//
//  PushNextViewController.m
//  ConfigNavigation
//
//  Created by hncoder on 2017/2/6.
//  Copyright © 2017年 hncoder. All rights reserved.
//

#import "PushNextViewController.h"

@interface PushNextViewController ()

@end

@implementation PushNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [[btn titleLabel] setFont:[UIFont systemFontOfSize:13]];
    [btn setTitle:@"PushNext" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn sizeToFit];
    
    btn.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0);
    
    int i = rand() % 3;
    if (i == 0)
    {
        self.title = @"Blue Controller";
        self.view.backgroundColor = [UIColor blueColor];
        self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    }
    else if(i == 1)
    {
        self.title = @"Red Controller";
        self.view.backgroundColor = [UIColor redColor];
        self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
        self.navigationController.navigationBar.tintColor = [UIColor redColor];
    }
    else
    {
        self.title = @"Green Controller";
        self.view.backgroundColor = [UIColor greenColor];
        self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clicked:(id)sender
{
    PushNextViewController *nextController = [[PushNextViewController alloc] init];
    
    [self.navigationController pushViewController:nextController animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
