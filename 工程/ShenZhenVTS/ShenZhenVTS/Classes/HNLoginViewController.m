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
#import "JSONKit.h"
#import "HNLoginView.h"
#import "HNSettingViewController.h"
#import "HNRegisterViewController.h"

@interface HNLoginModel: NSObject
@property (nonatomic, strong)NSString *username;
@property (nonatomic, strong)NSString *password;
@end
@implementation HNLoginModel
@end

@interface HNLoginViewController()

@property (nonatomic, strong)UIButton *loginButton;
@property (nonatomic, strong)UIButton *registerButton;
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
    
    
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerButton.frame = CGRectMake(0, 0, self.view.width - 36, 40);
    self.registerButton.top = self.loginButton.bottom + 9;
    self.registerButton.centerX = self.view.width / 2;
    [self.registerButton setTitle:NSLocalizedString(@"Register", nil) forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerButton addTarget:self action:@selector(registerUser:) forControlEvents:UIControlEventTouchUpInside];
    self.registerButton.layer.cornerRadius = 5.0;
    [self.registerButton setBackgroundColor:[UIColor colorWithRed:0.0 green:152.0/255.0 blue:233.0/255.0 alpha:1.0]];
    
    [self.view addSubview:self.loginView];
    [self.view addSubview:self.remember];
    [self.view addSubview:self.rememberLabel];
    [self.view addSubview:self.forget];

    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.registerButton];
    self.loginView.userName.text = @"1";
    self.loginView.password.text = @"1";

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view insertSubview:self.backImage belowSubview:self.loginView];
    self.backImage.frame = self.view.bounds;

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
    HNRegisterViewController *vc = [[HNRegisterViewController alloc]init];
    vc.type = KHNForgetPW;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)rememberPassword:(UIButton *)sender{
    sender.selected = !sender.selected;
}
- (void)login:(id)sender{

    [self loadMyData];
    

}

- (void)registerUser:(id)sender{
    
    HNRegisterViewController *vc = [[HNRegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)loginSuccess{
    HNSettingViewController *vc = [[HNSettingViewController alloc] init];
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController pushViewController:vc animated:NO];
    
    
    //self.tabBarController.selectedIndex = 0;
}

#pragma mark -loadData
-(void)loadMyData
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://202.104.126.36:8787/sz-web/plan/ShipController/login?name=%@&ps=%@",self.loginView.userName.text,self.loginView.password.text]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [self performSelectorOnMainThread:@selector(didloadMyData:) withObject:data waitUntilDone:YES];
    }];
}

- (void)didloadMyData:(NSData *)data
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (data)
    {
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",retStr);
        NSDictionary* dic = [retStr objectFromJSONString];
        
        if (![retStr isEqualToString:@"false"]){
            HNUserDate *userdata = [HNUserDate shared];
            userdata.userID = [dic objectForKey:@"id"];
            userdata.phonenum = [dic objectForKey:@"phonenum"];
            NSArray *array = [dic objectForKey:@"aisHeaders"];
            for (int i = 0; i<[array count]; i++) {
                NSDictionary *dicData = [array objectAtIndex:i];
                HNShipDynamicsModel *tModel = [[HNShipDynamicsModel alloc] init];
                [tModel updateDataLogin:dicData];
                [[HNUserDate shared].shipList addObject:tModel];
            }
            //userdata.phonenum = [dic objectForKey:@"phonenum"];
            [self loginSuccess];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Login Fail", nil) message:NSLocalizedString(@"Please input correct username and password", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
            [alert show];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }
}
@end
