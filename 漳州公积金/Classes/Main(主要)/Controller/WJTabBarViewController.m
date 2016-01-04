//
//  WJTabBarViewController.m
//  漳州公积金
//  自定义底部菜单
//

#import "WJTabBarViewController.h"
#import "WJHomeViewController.h"
#import "WJServicesViewController.h"
#import "WJMineViewController.h"
#import "WJSettingsViewController.h"
#import "WJNavigationController.h"
#import "WJTabBar.h"

@interface WJTabBarViewController () //<WJTabBarDelegate, UITabBarControllerDelegate>
@property (nonatomic, weak) WJHomeViewController *home;
@property (nonatomic, weak) WJServicesViewController *services;
@property (nonatomic, weak) WJSettingsViewController *settings;
@property (nonatomic, weak) WJMineViewController *mine;
@property (nonatomic, weak) UIViewController *lastSelectedViewContoller;
@end

@implementation WJTabBarViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加所有的子控制器
    [self addAllChildVcs];
    
    // 创建自定义tabbar
    [self addCustomTabBar];
    
}

//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UINavigationController *)viewController
//{
//    UIViewController *vc = [viewController.viewControllers firstObject];
//    if ([vc isKindOfClass:[WJHomeViewController class]]) {
//        if (self.lastSelectedViewContoller == vc) {
//            [self.home refresh:YES];
//        } else {
//            [self.home refresh:NO];
//        }
//    }
//    
//    self.lastSelectedViewContoller = vc;
//}

//- (void)getUnreadCount
//{
//    // 1.请求参数
//    WJUnreadCountParam *param = [WJUnreadCountParam param];
//    param.uid = [WJAccountTool account].uid;
//    
//    // 2.获得未读数
//    [WJUserTool unreadCountWithParam:param success:^(WJUnreadCountResult *result) {
//        // 显示微博未读数
//        if (result.status == 0) {
//            self.home.tabBarItem.badgeValue = nil;
//        } else {
//            self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
//        }
//        
//        // 显示消息未读数
//        if (result.messageCount == 0) {
//            self.message.tabBarItem.badgeValue = nil;
//        } else {
//            self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
//        }
//        
//        // 显示新粉丝数
//        if (result.follower == 0) {
//            self.profile.tabBarItem.badgeValue = nil;
//        } else {
//            self.profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
//        }
//        
//        // 在图标上显示所有的未读数
//        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
//        WJLog(@"总未读数--%d", result.totalCount);
//    } failure:^(NSError *error) {
//        WJLog(@"获得未读数失败---%@", error);
//    }];
//}

/**
 *  创建自定义tabbar
 */
- (void)addCustomTabBar
{
    // 创建自定义tabbar
    WJTabBar *customTabBar = [[WJTabBar alloc] init];
    //customTabBar.tabBarDelegate = self;
    // 更换系统自带的tabbar
    [self setValue:customTabBar forKeyPath:@"tabBar"];
}

/**
 *  添加所有的子控制器
 */
- (void)addAllChildVcs
{
    WJHomeViewController *home = [[WJHomeViewController alloc] init];
    [self addOneChlildVc:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.home = home;
    self.lastSelectedViewContoller = home;
    
    WJServicesViewController *services = [[WJServicesViewController alloc] init];
    [self addOneChlildVc:services title:@"便民服务" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    self.services = services;
    
    WJMineViewController *mine = [[WJMineViewController alloc] init];
    [self addOneChlildVc:mine title:@"个人中心" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    self.mine= mine;
    
    WJSettingsViewController *settings = [[WJSettingsViewController alloc] init];
    [self addOneChlildVc:settings title:@"设置" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    self.settings = settings;
}

/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 设置标题
    childVc.title = title;
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //textAttrs[UITextAttributeTextColor] = [UIColor blackColor];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    //textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:10];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    selectedTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    if (iOS7) {
        // 声明这张图片用原图(别渲染)
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 添加为tabbar控制器的子控制器
    WJNavigationController *nav = [[WJNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

@end