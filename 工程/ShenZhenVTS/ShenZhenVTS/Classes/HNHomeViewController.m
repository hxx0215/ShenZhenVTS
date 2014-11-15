//
//  HNHomeViewController.m
//  edecorate
//
//  Created by hxx on 9/17/14.
//
//

#import "HNHomeViewController.h"
#import "UIView+AHKit.h"
#import "HNHomeHeadView.h"

#define WSpace 108/2
#define hSpace 74/2
#define tSpacePer 0.1
#define decorTop 160/2
#define btnHeight 106/2
#define busiTop (decorTop+btnHeight+hSpace)
#define messTop (busiTop+btnHeight+hSpace)

@interface HNHomeViewController ()
@property (nonatomic, strong)UIButton *decorateControlButton;
@property (nonatomic, strong)UIButton *businessBackgroundButton;
@property (nonatomic, strong)UIButton *messageButton;
@property (nonatomic, strong)UIBarButtonItem *settingButton;
@property (nonatomic, strong)UIWebView *myWebView;
@property (nonatomic, strong)HNHomeHeadView *myheadView;
@end


@implementation HNHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = NSLocalizedString(@"E Decorate", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"ShenZhenVTS";
    
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
//    [imageView setImage:[UIImage imageNamed:@"loading_activity_background"]];
   // [self.view addSubview:imageView];
    self.myWebView=[[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.myWebView];
    //@"http://www.zchxlab.com/
    NSURL *url=[NSURL URLWithString:@"http://202.104.126.36:8787/sz-web/mobile/"];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    [self.myWebView loadRequest:request];
    
    self.myheadView = [[HNHomeHeadView alloc]init];
    [self.view addSubview:self.myheadView];
    
    //[self initNaviButton];
    /*
    self.decorateControlButton = [self createButtonWithTitle:NSLocalizedString(@"Decorate Control", nil) selector:@selector(decorateControlButton_Clicked:) textColor:[UIColor colorWithRed:0x00/255.0 green:0xa5/255.0 blue:0xf6/255.0 alpha:1]];
    
    self.businessBackgroundButton = [self createButtonWithTitle:NSLocalizedString(@"Business Background", nil) selector:@selector(businessBackgroundButton_Clicked:) textColor:[UIColor colorWithRed:0xe5/255.0 green:0x7d/255.0 blue:0x45/255.0 alpha:1]];
    [self.view addSubview:self.decorateControlButton];
    [self.view addSubview:self.businessBackgroundButton];
    self.messageButton = [self createButtonWithTitle:NSLocalizedString(@"Message", nil) selector:@selector(messageButton_Clicked:) textColor:[UIColor colorWithRed:0x24/255.0 green:0xb5/255.0 blue:0x3c/255.0 alpha:1]];
    [self.view addSubview:self.messageButton];
    
    self.settingButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Setting", nil) style:UIBarButtonItemStylePlain target:self action:@selector(settingButton_Clicked:)];
    [self.settingButton setImage:[UIImage imageNamed:@"设置_11.png"]];
    self.navigationItem.rightBarButtonItem = self.settingButton;
     */
}

- (UIButton *)createButtonWithTitle:(NSString *)title selector:(SEL)selector textColor:(UIColor *)color{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    btn.layer.cornerRadius = 5.0;
//    UIImage* image = [UIImage imageNamed:@"按键点击.9.png"];
//    [btn setImage:image forState:UIControlStateNormal];
    //[btn sizeToFit];
    btn.width = self.view.width - 2 * WSpace;
    btn.height = btnHeight;
    btn.left = WSpace;
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = [UIColor colorWithWhite:173.0/255.0 alpha:1.0].CGColor;
    [btn addTarget:self action:@selector(highlightButton:) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(normalButton:) forControlEvents:UIControlEventTouchUpOutside];
    return btn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.myheadView.frame = CGRectMake(0, 0, self.view.width, 40);
    self.myWebView.frame = CGRectMake(0, 40, self.view.width, self.view.height-40);
}
- (void)setMyInterfaceOrientation:(UIInterfaceOrientation)orientation{
    if (UIInterfaceOrientationIsPortrait(orientation)){
        self.decorateControlButton.top = decorTop;
        self.businessBackgroundButton.top = busiTop;
        self.messageButton.top = messTop;
    }
    else{
    }
}
- (void)highlightButton:(UIButton *)sender{
    [sender setBackgroundColor:[UIColor colorWithWhite:224.0/255.0 alpha:1.0]];
}
- (void)normalButton:(UIButton *)sender{
    [sender setBackgroundColor:[UIColor whiteColor]];
}
//- (void)decorateControlButton_Clicked:(UIButton *)sender{
//    NSLog(@"decor");
//    [sender setBackgroundColor:[UIColor whiteColor]];
//    HNDecorateControlViewController* DC = [[HNDecorateControlViewController alloc]init];
////    [self presentViewController:DC animated:YES completion:^{}];
//    [self.navigationController pushViewController:DC animated:YES];
//}
//
//- (void)businessBackgroundButton_Clicked:(UIButton *)sender{
//    [sender setBackgroundColor:[UIColor whiteColor]];
//    HNBusinessBKControlViewController* bc = [[HNBusinessBKControlViewController alloc]init];
//    [self.navigationController pushViewController:bc animated:YES];
//    NSLog(@"busi");
//}
//- (void)messageButton_Clicked:(UIButton *)sender{
//    [sender setBackgroundColor:[UIColor whiteColor]];
//    if (!self.messageViewController){
//        self.messageViewController = [[HNMessageViewController alloc] init];
//    }
//    [self.navigationController pushViewController:self.messageViewController animated:YES];
//}

- (void)settingButton_Clicked:(id)sender{
    NSLog(@"setting");
}

-  (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
