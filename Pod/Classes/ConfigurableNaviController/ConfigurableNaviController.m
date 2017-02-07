//
//  ConfigurableNaviController.m
//  ConfigurableNavigation
//
//  Created by hncoder on 2017/2/5.
//  Copyright © 2017年 hncoder. All rights reserved.
//

#import "ConfigurableNaviController.h"


@interface ConfigurableWrapViewController : UIViewController

@property (nonatomic , strong) UIViewController * entity;

@end

@implementation ConfigurableWrapViewController

#pragma mark - overriding

- (BOOL)hidesBottomBarWhenPushed
{
    return [self entity].hidesBottomBarWhenPushed;
}

- (UITabBarItem *)tabBarItem
{
    return [self entity].tabBarItem;
}

- (NSString *)title
{
    return [self entity].title;
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return [self entity];
}

- (UIViewController *)childViewControllerForStatusBarHidden
{
    return [self entity];
}

#pragma mark - getter

- (UIViewController *)entity
{
    ConfigurableNaviController *wrapperNavController = self.childViewControllers.firstObject;
    return wrapperNavController.childViewControllers.firstObject;
}

@end

#define kAnimationDuration (0.25)
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ConfigurableTransitionAnimation : NSObject<UIViewControllerAnimatedTransitioning>
- (void)setupTransitioningAnimationFrom:(UIViewController *)fromViewController
                                     to:(UIViewController *)toViewController
                              container:(UIView *)containerView
                                context:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)setShadowWithController:(UIViewController *)controller;
- (void)setNavigationBarOriginXWithController:(UIViewController *)controller originX:(CGFloat)x;
- (void)setNavigationBarItemsAlphaWithController:(UIViewController *)controller alpha:(CGFloat)alpha;
- (UIViewController *)entityControllerWithWrapController:(UIViewController *)wrapController;
@end

@implementation ConfigurableTransitionAnimation
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return kAnimationDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [self setupTransitioningAnimationFrom:fromViewController to:toViewController container:containerView context:transitionContext];
}

- (void)setupTransitioningAnimationFrom:(UIViewController *)fromViewController
                                     to:(UIViewController *)toViewController
                              container:(UIView *)containerView
                                context:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // Implementation in subclass
    assert(0);
}

- (void)setShadowWithController:(UIViewController *)controller
{
    controller.view.layer.shadowColor = [[UIColor blackColor] CGColor];
    controller.view.layer.shadowOpacity = 0.6;
    controller.view.layer.shadowRadius = 8;
}

- (void)setNavigationBarOriginXWithController:(UIViewController *)controller originX:(CGFloat)x
{
    CGRect frame = controller.navigationController.navigationBar.frame;
    frame.origin.x = x;
    controller.navigationController.navigationBar.frame = frame;
}

- (void)setNavigationBarItemsAlphaWithController:(UIViewController *)controller alpha:(CGFloat)alpha
{
    controller.navigationItem.leftBarButtonItem.customView.alpha = alpha;
    controller.navigationItem.titleView.alpha = alpha;
    controller.navigationItem.rightBarButtonItem.customView.alpha = alpha;
    controller.navigationController.navigationBar.alpha = alpha;
}

- (UIViewController *)entityControllerWithWrapController:(UIViewController *)wrapController
{
    if ([wrapController isKindOfClass:[ConfigurableWrapViewController class]])
    {
        return [(ConfigurableWrapViewController *)wrapController entity];
    }
    
    return wrapController;
}

@end

@interface ConfigurablePushTransitionAnimation1 : ConfigurableTransitionAnimation
@end

@implementation ConfigurablePushTransitionAnimation1

- (void)setupTransitioningAnimationFrom:(UIViewController *)fromViewController
                                     to:(UIViewController *)toViewController
                              container:(UIView *)containerView
                                context:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [containerView insertSubview:toViewController.view
                    aboveSubview:fromViewController.view];
    
    toViewController.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
    [self setShadowWithController:toViewController];
    
    [self setNavigationBarOriginXWithController:[self entityControllerWithWrapController:toViewController] originX:-kScreenWidth];
    [self setNavigationBarItemsAlphaWithController:[self entityControllerWithWrapController:toViewController] alpha:0.0];
    [self setNavigationBarItemsAlphaWithController:[self entityControllerWithWrapController:fromViewController] alpha:1.0];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^
    {
         toViewController.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
         [self setNavigationBarOriginXWithController:[self entityControllerWithWrapController:toViewController] originX:0];
         [self setNavigationBarItemsAlphaWithController:[self entityControllerWithWrapController:toViewController] alpha:1.0];
         [self setNavigationBarItemsAlphaWithController:[self entityControllerWithWrapController:fromViewController] alpha:0.0];
         
    }
    completion:^(BOOL finished)
    {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end

@interface ConfigurablePopTransitionAnimation1 : ConfigurableTransitionAnimation
@end

@implementation ConfigurablePopTransitionAnimation1

- (void)setupTransitioningAnimationFrom:(UIViewController *)fromViewController
                                     to:(UIViewController *)toViewController
                              container:(UIView *)containerView
                                context:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [containerView insertSubview:toViewController.view
                    belowSubview:fromViewController.view];
    
    [self setShadowWithController:fromViewController];
    
    [self setNavigationBarOriginXWithController:[self entityControllerWithWrapController:fromViewController] originX:0];
    [self setNavigationBarItemsAlphaWithController:[self entityControllerWithWrapController:fromViewController] alpha:1.0];
    [self setNavigationBarItemsAlphaWithController:[self entityControllerWithWrapController:toViewController] alpha:0.0];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^
     {
         fromViewController.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
         [self setNavigationBarOriginXWithController:[self entityControllerWithWrapController:fromViewController] originX:-kScreenWidth];
         [self setNavigationBarItemsAlphaWithController:[self entityControllerWithWrapController:fromViewController] alpha:0.0];
         [self setNavigationBarItemsAlphaWithController:[self entityControllerWithWrapController:toViewController] alpha:1.0];
     }
     completion:^(BOOL finished)
     {
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
     }];
}

@end

@interface ConfigurablePushTransitionAnimation2 : ConfigurableTransitionAnimation
@end

@implementation ConfigurablePushTransitionAnimation2
- (void)setupTransitioningAnimationFrom:(UIViewController *)fromViewController
                                     to:(UIViewController *)toViewController
                              container:(UIView *)containerView
                                context:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [containerView insertSubview:toViewController.view
                    aboveSubview:fromViewController.view];
    
    toViewController.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
    [self setShadowWithController:toViewController];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^
    {
        toViewController.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }
    completion:^(BOOL finished)
    {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end

@interface ConfigurablePopTransitionAnimation2 : ConfigurableTransitionAnimation
@end

@implementation ConfigurablePopTransitionAnimation2

- (void)setupTransitioningAnimationFrom:(UIViewController *)fromViewController
                                     to:(UIViewController *)toViewController
                              container:(UIView *)containerView
                                context:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [containerView insertSubview:toViewController.view
                    belowSubview:fromViewController.view];
    
    [self setShadowWithController:fromViewController];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^
     {
         fromViewController.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
     }
                     completion:^(BOOL finished)
     {
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
     }];
}

@end

@interface ConfigurablePushTransitionAnimation3 : ConfigurableTransitionAnimation
@property (nonatomic, strong) UIView *shadowView;
@end

@implementation ConfigurablePushTransitionAnimation3

- (UIView *)shadowView
{
    if (!_shadowView)
    {
        _shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    
    return _shadowView;
}

- (void)setupTransitioningAnimationFrom:(UIViewController *)fromViewController
                                     to:(UIViewController *)toViewController
                              container:(UIView *)containerView
                                context:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [fromViewController.view addSubview:self.shadowView];
    
    [containerView insertSubview:toViewController.view
                    aboveSubview:fromViewController.view];
    
    toViewController.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
    [self setShadowWithController:toViewController];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^
    {
        self.shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
        fromViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
        toViewController.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }
    completion:^(BOOL finished)
    {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        [self.shadowView removeFromSuperview];
    }];
}

@end

@interface ConfigurablePopTransitionAnimation3 : ConfigurableTransitionAnimation
@property (nonatomic, strong) UIView *shadowView;
@end

@implementation ConfigurablePopTransitionAnimation3

- (UIView *)shadowView
{
    if (!_shadowView)
    {
        _shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    
    return _shadowView;
}

- (void)setupTransitioningAnimationFrom:(UIViewController *)fromViewController
                                     to:(UIViewController *)toViewController
                              container:(UIView *)containerView
                                context:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    [toViewController.view addSubview:self.shadowView];

    [containerView insertSubview:toViewController.view
                    belowSubview:fromViewController.view];
    
    toViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
    
    [self setShadowWithController:fromViewController];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^
    {
        self.shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        fromViewController.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
        toViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }
    completion:^(BOOL finished)
    {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        [self.shadowView removeFromSuperview];
    }];

}

@end

@interface ConfigurableNaviController ()<UINavigationControllerDelegate>

@property (nonatomic , weak) ConfigurableNaviController *proxy;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *popDrivenInteractiveTransition;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *popGestureRecognizer;

@end


@implementation ConfigurableNaviController

#pragma mark - Overwrite methods

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super init];
    if (self)
    {
        self.viewControllers = @[ [self wrapControllerWithViewController:rootViewController] ];
        self.delegate = self;
        self.navigationBarHidden = YES;
        self.transAnimStyle = ConfigurableTransAnimStyleDefault;
        self.proxy = nil;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addActionToPopGestureRecognizer];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.proxy)
    {
        [self.proxy pushViewController:viewController animated:animated];
    }
    else
    {
        if (self.childViewControllers.count > 0)
        {
            [self configDefaultLeftBarItemWithViewContrller:viewController];
        }
        
        [super pushViewController:[self wrapControllerWithViewController:viewController] animated:animated];
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (self.proxy)
    {
        return [self.proxy popViewControllerAnimated:animated];
    }
    else
    {
        UIViewController * popedController = [super popViewControllerAnimated:animated];
        return [self entityControllerWithViewController:(ConfigurableWrapViewController *)popedController];
    }
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.proxy)
    {
        return [self.proxy popToViewController:viewController animated:animated];
    }
    else
    {
        UIViewController * wrapViewContrller = viewController.navigationController.parentViewController;
        if ([wrapViewContrller isMemberOfClass:[ConfigurableWrapViewController class]])
        {
            viewController = wrapViewContrller;
        }
        
        if (viewController && ![self.childViewControllers containsObject:viewController])
        {
            return nil;
        }
        
        NSArray * contrllers = [super popToViewController:viewController animated:animated];
        
        return [self entityControllersWithViewControllers:contrllers];
    }
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    if (self.proxy)
    {
        return [self.proxy popToRootViewControllerAnimated:animated];
    }
    else
    {
        NSArray * contrllers = [super popToRootViewControllerAnimated:animated];
        return [self entityControllersWithViewControllers:contrllers];
    }
}

- (NSArray<UIViewController *> *)viewControllers
{
    if (self.proxy)
    {
        return self.proxy.viewControllers;
    }
    
    NSArray * viewContrlllers = [super viewControllers];
    return [self entityControllersWithViewControllers:viewContrlllers];
}

- (UIViewController *)visibleViewController
{
    if (self.proxy)
    {
        return self.proxy.visibleViewController;
    }
    
    return  [self entityControllerWithViewController:(ConfigurableWrapViewController *)[super visibleViewController]];
}

- (id<UINavigationControllerDelegate>)delegate
{
    if (self.proxy)
    {
        return self.proxy.delegate;
    }
    else
    {
        return [super delegate];
    }
}

- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate
{
    if (self.proxy)
    {
        [self.proxy setDelegate:delegate];
    }
    else
    {
        [super setDelegate:delegate];
    }
}

- (UIGestureRecognizer *)interactivePopGestureRecognizer
{
    if (self.proxy)
    {
        return self.proxy.interactivePopGestureRecognizer;
    }
    
    return self.popGestureRecognizer;
}

- (BOOL)isToolbarHidden
{
    if (self.proxy)
    {
        return [self.proxy isToolbarHidden];
    }
    
    return [super isToolbarHidden];
}

- (void)setToolbarHidden:(BOOL)hidden animated:(BOOL)animated
{
    if (self.proxy)
    {
        return [self.proxy setToolbarHidden:hidden animated:animated];
    }
    
    [super setToolbarHidden:hidden animated:animated];
}

- (UIToolbar *)toolbar
{
    if (self.proxy)
    {
        return self.proxy.toolbar;
    }
    
    return [super toolbar];
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated
{
    if (self.proxy)
    {
        if ([super viewControllers].count)
        {
            NSMutableArray * contrllers = [[NSMutableArray alloc] initWithCapacity:viewControllers.count];
            for (UIViewController * contrller in viewControllers)
            {
                UIViewController * warpContrller = [self wrapControllerWithViewController:contrller];
                if (warpContrller)
                {
                    [contrllers addObject:warpContrller];
                }
            }
            
            return [self.proxy setViewControllers:contrllers animated:animated];
        }
    }
    
    [super setViewControllers:viewControllers animated:animated];
}

- (void)viewWillLayoutSubviews
{
    if (!self.proxy)
    {
        if (self.navigationBar.hidden == false)
        {
            self.navigationBar.hidden = true;
        }
    }
    
    [super viewWillLayoutSubviews];
}

#pragma mark - Private methods

- (void)addActionToPopGestureRecognizer
{
    if (!self.proxy)
    {
        self.popGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(proxyPopGestureRecognizer:)];
        self.popGestureRecognizer.edges = UIRectEdgeLeft;
        [self.view addGestureRecognizer:self.popGestureRecognizer];
    }
}

- (void)proxyPopGestureRecognizer:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        self.popDrivenInteractiveTransition =  [UIPercentDrivenInteractiveTransition new];
        [self popViewControllerAnimated:YES];
    }
    else
    {
        CGPoint point = [recognizer translationInView:recognizer.view];
        CGFloat progress = point.x / recognizer.view.bounds.size.width;
        
        if (recognizer.state == UIGestureRecognizerStateChanged)
        {
            [self.popDrivenInteractiveTransition updateInteractiveTransition:progress];
        }
        else
        {
            if(progress > 0.5)
            {
                [self.popDrivenInteractiveTransition finishInteractiveTransition];
            }
            else
            {
                [self.popDrivenInteractiveTransition cancelInteractiveTransition];
            }
            
            self.popDrivenInteractiveTransition = nil;
        }
    }
}

- (void)configDefaultLeftBarItemWithViewContrller:(UIViewController *)viewContrlller
{
    UIViewController * entity = viewContrlller;
    
    if (!entity.navigationItem.leftBarButtonItem)
    {
        UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:(UIBarButtonItemStylePlain) target:self action:@selector(onLeftBarItemClick:)];
        entity.navigationItem.leftBarButtonItem = leftItem;
    }
}

- (void)onLeftBarItemClick:(id)sender
{
    [self popViewControllerAnimated:YES];
}

- (UIViewController *)wrapControllerWithViewController:(UIViewController *)viewControlller
{
    UIViewController * wrapViewController = [ConfigurableWrapViewController new];
    Class navigationControllerClass = [self class];
    
    ConfigurableNaviController * navigationController = [navigationControllerClass new];
    navigationController.proxy = self;
    navigationController.viewControllers = @[viewControlller];
    
    [wrapViewController.view addSubview:navigationController.view];
    [wrapViewController addChildViewController:navigationController];
    
    return wrapViewController;
}

- (UIViewController *)entityControllerWithViewController:(ConfigurableWrapViewController *)wrapViewContrller
{
    if ([wrapViewContrller isKindOfClass:[ConfigurableWrapViewController class]])
    {
        return wrapViewContrller.entity;
    }
    
    return wrapViewContrller;
}

- (NSArray<UIViewController *> *)entityControllersWithViewControllers:(NSArray<ConfigurableWrapViewController *> *)viewControlllers
{
    NSMutableArray * contrllers = [[NSMutableArray alloc] initWithCapacity:viewControlllers.count];
    for (ConfigurableWrapViewController * contrller  in viewControlllers)
    {
        [contrllers addObject:[self entityControllerWithViewController:contrller]];
    }
    
    return contrllers;
}

- (id<UIViewControllerAnimatedTransitioning>)pushTransitionAnimation
{
    id<UIViewControllerAnimatedTransitioning> transitionAnimation = nil;
    switch (self.transAnimStyle)
    {
        case ConfigurableTransAnimStyle1:
            transitionAnimation = [ConfigurablePushTransitionAnimation1 new];
            break;
            
        case ConfigurableTransAnimStyle2:
            transitionAnimation = [ConfigurablePushTransitionAnimation2 new];
            break;
            
        case ConfigurableTransAnimStyle3:
            transitionAnimation = [ConfigurablePushTransitionAnimation3 new];
            break;
            
        default:
            break;
    }
    
    return transitionAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)popTransitionAnimation
{
    id<UIViewControllerAnimatedTransitioning> transitionAnimation = nil;
    switch (self.transAnimStyle)
    {
        case ConfigurableTransAnimStyle1:
            transitionAnimation = [ConfigurablePopTransitionAnimation1 new];
            break;
            
        case ConfigurableTransAnimStyle2:
            transitionAnimation = [ConfigurablePopTransitionAnimation2 new];
            break;
            
        case ConfigurableTransAnimStyle3:
            transitionAnimation = [ConfigurablePopTransitionAnimation3 new];
            break;
            
        default:
            break;
    }
    
    return transitionAnimation;
}

#pragma mark - UINavigationControllerDelegate
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return [animationController isKindOfClass:[ConfigurablePopTransitionAnimation1 class]]
        || [animationController isKindOfClass:[ConfigurablePopTransitionAnimation2 class]]
        || [animationController isKindOfClass:[ConfigurablePopTransitionAnimation3 class]] ? self.popDrivenInteractiveTransition : nil;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    id <UIViewControllerAnimatedTransitioning> transitioning = nil;
    if (operation == UINavigationControllerOperationPush)
    {
        transitioning = [self pushTransitionAnimation];
    }
    else if (operation == UINavigationControllerOperationPop)
    {
        transitioning = [self popTransitionAnimation];
    }
    
    return transitioning;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self.proxyDelegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)])
    {
        [self.proxyDelegate navigationController:navigationController willShowViewController:[self entityControllerWithViewController:(ConfigurableWrapViewController *)viewController] animated:animated];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self.proxyDelegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)])
    {
        [self.proxyDelegate navigationController:navigationController didShowViewController:[self entityControllerWithViewController:(ConfigurableWrapViewController *)viewController] animated:animated];
    }
}

@end

@implementation UIViewController(ConfigurableNaviController)

- (ConfigurableNaviController *)proxyNavigationController;
{
    ConfigurableNaviController *proxyNavigationController = (ConfigurableNaviController *)[self navigationController];
    if ([proxyNavigationController isKindOfClass:[ConfigurableNaviController class]])
    {
        if (proxyNavigationController.proxy)
        {
            proxyNavigationController = proxyNavigationController.proxy;
        }
    }
    else
    {
        proxyNavigationController = nil;
    }
    
    return proxyNavigationController;
}

@end
