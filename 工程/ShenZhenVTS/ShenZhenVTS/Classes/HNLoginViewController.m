//
//  HNLoginViewController.m
//  edecorate
//
//  Created by hxx on 9/18/14.
//
//

#import "HNLoginViewController.h"
#import "UIView+AHKit.h"
#import "HNHomeViewController.h"
#import "MBProgressHUD.h"
#import "HNLoginView.h"

@interface HNLoginModel: NSObject
@property (nonatomic, strong)NSString *username;
@property (nonatomic, strong)NSString *password;
@end
@implementation HNLoginModel
@end

@interface HNLoginViewController()

@property (nonatomic, strong)UIButton *loginButton;
@property (nonatomic, strong)UIImageView *backImage;
@property (nonatomic, strong)HNLoginView *loginView;
@property (nonatomic, strong)UIButton *remember;
@property (nonatomic, strong)UILabel *rememberLabel;
@property (nonatomic, strong)UIButton *forget;
@end
@implementation HNLoginViewController
- (instancetype)init{
    self = [super init];
    if (self){
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSLocalizedString(@"Login", nil);
    self.backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loginback.png"]];

    self.loginView = [[HNLoginView alloc] initWithFrame:CGRectMake(18, 18, self.view.width - 36, 81)];
    
    self.remember = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.remember setBackgroundImage:[UIImage imageNamed:@"remember.png"] forState:UIControlStateNormal];
    [self.remember setImage:[UIImage imageNamed:@"rememberit.png"] forState:UIControlStateSelected];
    [self.remember addTarget:self action:@selector(rememberPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.remember sizeToFit];
    self.remember.top = self.loginView.bottom + 9;
    self.remember.left = self.loginView.left;
    self.rememberLabel = [[UILabel alloc] init];
    self.rememberLabel.text = NSLocalizedString(@"Remember", nil);
    [self.rememberLabel sizeToFit];
    self.rememberLabel.textColor = [UIColor colorWithWhite:102.0/255.0 alpha:1.0];
    self.rememberLabel.centerY = self.remember.centerY;
    self.rememberLabel.left = self.remember.right;
    
    self.forget = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.forget setTitle:NSLocalizedString(@"Forget Password?", nil) forState:UIControlStateNormal];
    [self.forget setTitleColor:[UIColor colorWithRed:45.0/255.0 green:138.0/255.0 blue:204.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.forget addTarget:self action:@selector(fogetPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.forget sizeToFit];
    self.forget.right = self.loginView.right;
    self.forget.centerY = self.rememberLabel.centerY;
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.frame = CGRectMake(0, 0, self.view.width - 36, 40);
    self.loginButton.top = self.remember.bottom + 9;
    self.loginButton.centerX = self.view.width / 2;
    [self.loginButton setTitle:NSLocalizedString(@"Login", nil) forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton.layer.cornerRadius = 5.0;
    [self.loginButton setBackgroundColor:[UIColor colorWithRed:0.0 green:152.0/255.0 blue:233.0/255.0 alpha:1.0]];
    
    [self.view addSubview:self.loginView];
    [self.view addSubview:self.remember];
    [self.view addSubview:self.rememberLabel];
    [self.view addSubview:self.forget];

    [self.view addSubview:self.loginButton];
    self.loginView.userName.text = @"admin";
    self.loginView.password.text = @"123456";

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.view insertSubview:self.backImage atIndex:100];
    [self.view insertSubview:self.backImage belowSubview:self.loginView];

}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.backImage removeFromSuperview];
}

- (NSDictionary *)encodeWithLoginModel:(HNLoginModel *)model{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:model.username,@"username",model.password,@"password", nil];
    return dic;
}

- (void)fogetPassword:(id)sender{
    NSLog(@"foget password");
}
- (void)rememberPassword:(UIButton *)sender{
    sender.selected = !sender.selected;
}
- (void)login:(id)sender{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
                [self loginSuccess];

}

- (void)loginSuccess{
    HNHomeViewController *homeViewController = [[HNHomeViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    nav.navigationBar.translucent = NO;
    [self presentViewController:nav animated:YES completion:nil];
    //self.tabBarController.selectedIndex = 0;
}

- (void)changeViewControlelr:(id)sender{
    
}


- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers
{
    NSLog(@"willBeginCustomizingViewControllers: %@", viewControllers);
}

- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
    NSLog(@"viewcontrollers: %@, ischanged: %d", viewControllers, changed);
}


- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
    NSLog(@"didEndCustomizingViewController!");
    NSLog(@"didEndCustomizingViewController: %@, ischanged: %d", viewControllers, changed);
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
//    NSLog(@"didSelectViewController!");
}

@end
