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
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import "HNShipDynamicsModel.h"
#import "HNShipDetailViewController.h"
#import "HNMessageViewController.h"
#import "HNSettingViewController.h"
#import "HNSearchViewController.h"
#import "HNLoginViewController.h"
#import "HNUserModel.h"

#define WSpace 108/2
#define hSpace 74/2
#define tSpacePer 0.1
#define decorTop 160/2
#define btnHeight 106/2
#define busiTop (decorTop+btnHeight+hSpace)
#define messTop (busiTop+btnHeight+hSpace)

@interface HNHomeViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong)UIButton *decorateControlButton;
@property (nonatomic, strong)UIButton *businessBackgroundButton;
@property (nonatomic, strong)UIButton *messageButton;
@property (nonatomic, strong)UIBarButtonItem *settingButton;
@property (nonatomic, strong)UIWebView *myWebView;
@property (nonatomic, strong)HNHomeHeadView *myheadView;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *shipList;
@property (nonatomic, strong)NSArray *shipdynamicArray;
@end


@implementation HNHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = NSLocalizedString(@"E Decorate", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    //self.navigationItem.title = @"深圳VTS";
    
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
//    [imageView setImage:[UIImage imageNamed:@"loading_activity_background"]];
   // [self.view addSubview:imageView];
    self.myWebView=[[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.myWebView];
    //@"http://www.zchxlab.com/
    NSURL *url=[NSURL URLWithString:@"http://58.251.165.89:8787/sz-web/mobile/"];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    [self.myWebView loadRequest:request];
    self.myWebView.delegate = self;
    self.myheadView = [[HNHomeHeadView alloc]init];
    //[self.view addSubview:self.myheadView];
    
    
    [self.myheadView.segmentView addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self.myheadView.serchButton addTarget:self action:@selector(searchButton_Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.myheadView.messageButton addTarget:self action:@selector(messageButton_Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.myheadView.settingButton addTarget:self action:@selector(settingButton_Clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.hidden = YES;
    [self.view addSubview:self.tableView];
    
    self.shipList = [[NSMutableArray alloc]init];
    
    self.shipdynamicArray = [NSArray arrayWithObjects:@"shipdynamic是0",@"预抵",@"预离",@"正在抵港",@"正在离港",@"移泊",@"已靠泊",@"已锚泊",@"已离港",@"预抵",@"预抵", nil];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.myheadView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.myWebView.frame = self.view.bounds;//CGRectMake(0, 0, self.view.width, 40);
    
    self.tableView.frame = self.view.bounds;//CGRectMake(0, 40, self.view.width, self.view.height-40);
    self.shipList = [HNUserDate shared].shipList;
    
    self.myheadView.frame = self.navigationController.navigationBar.bounds;//CGRectMake(0, 40, self.view.width, self.view.height-40);
    [self.navigationController.navigationBar addSubview:self.myheadView];
    if ([HNUserDate shared].showString) {
        [self.myheadView.segmentView setSelectedSegmentIndex:0];
        self.tableView.hidden = YES;
        self.myWebView.hidden = NO;
        NSString * jsstr = [NSString stringWithFormat:@"mapTool.findShipByParam(\'%@\');",[HNUserDate shared].showString];
        NSString *js_result2 = [self.myWebView stringByEvaluatingJavaScriptFromString:jsstr];
        NSLog(@"%@",jsstr);
        NSLog(@"%@",js_result2);
        [HNUserDate shared].showString = nil;
    }
    [self.tableView reloadData];
    
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

- (void)searchButton_Clicked:(id)sender{
    HNSearchViewController *vc = [[HNSearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)messageButton_Clicked:(id)sender{
    HNMessageViewController *vc = [[HNMessageViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)settingButton_Clicked:(id)sender{

    if ([HNUserDate shared].userID) {
        HNSettingViewController *vc = [[HNSettingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        HNLoginViewController *vc = [[HNLoginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
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

#pragma mark -UIWebView
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = [request.URL absoluteString];
    NSRange range=[url rangeOfString:@"mapapp:" options:NSCaseInsensitiveSearch];
    if(range.length>0) {
        NSString *mmsi = [url substringFromIndex:range.location +
                       range.length];
        NSLog(@"%@",url);
        NSLog(@"%@",mmsi);
        HNShipDynamicsModel *model = [[HNShipDynamicsModel alloc]init];
        model.mmsi = mmsi;
        HNShipDetailViewController *vc = [[HNShipDetailViewController alloc]init];
        vc.shipModel = model;
        vc.type = KHNUnSee;
        [self.navigationController pushViewController:vc animated:YES];
        return FALSE;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

#pragma mark -UISegmentedControl

-(void)segmentAction:(UISegmentedControl *)Seg{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    
    
    switch (Index) {
            
        case 0:
            
            self.tableView.hidden = YES;
            self.myWebView.hidden = NO;
            
            break;
            
        case 1:
        {
            if (![HNUserDate shared].userID) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"请先登录", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                alert.tag =1;
                [alert show];
            }
            [self.tableView reloadData];
            self.tableView.hidden = NO;
            self.myWebView.hidden = YES;
            //[self loadMyData];
            
        }
            break;
            
            
        default:
            
            break;
            
    }
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==1) {
        [self settingButton_Clicked:0];
    }
}

#pragma mark - tableView Delegate & DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.shipList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"ArchivesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }
    HNShipDynamicsModel *model =self.shipList[indexPath.row];
    cell.textLabel.text = model.shipname;
    cell.textLabel.textColor = [UIColor darkTextColor];
    cell.detailTextLabel.text = [self.shipdynamicArray objectAtIndex:model.shipdynamic.integerValue ];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger row = indexPath.row;
    HNShipDetailViewController * vc = [[HNShipDetailViewController alloc]init];
    vc.shipModel = [self.shipList objectAtIndex:row];
    [self.navigationController pushViewController:vc animated:YES];
//    HNArchivesDecorateModel* model = self.modelList[row];
//    {
//        HNArchivesListViewController* dac = [[HNArchivesListViewController alloc]init];
//        dac.dID = model.declareId;
//        [self.navigationController pushViewController:dac animated:YES];
//    }
    
}

//#pragma mark -loadData
//-(void)loadMyData
//{
//    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.labelText = NSLocalizedString(@"Loading", nil);
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    
//    
//    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"https://szweb.pagekite.me/sz-web/plan/DynamicController/findShipDynamicPager?pageSize=%d&pageNo=%d&dynamic=",1,1]];
//    NSString *contentType = @"text/html";
//    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
//        [self performSelectorOnMainThread:@selector(didloadMyData:) withObject:data waitUntilDone:YES];
//    }];
//}
//
//- (void)didloadMyData:(NSData *)data
//{
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    
//    if (data)
//    {
//        [self.shipList removeAllObjects];
//        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",retStr);
//        NSDictionary* dic = [retStr objectFromJSONString];
//        NSNumber* total = [dic objectForKey:@"total"];
//        
//        if (total.intValue){//之后需要替换成status
//            NSArray* array = [dic objectForKey:@"shipDynamics"];
//            for (int i = 0; i<[array count]; i++) {
//                NSDictionary *dicData = [array objectAtIndex:i];
//                HNShipDynamicsModel *tModel = [[HNShipDynamicsModel alloc] init];
//                [tModel updateDataLogin:dicData];
//                [self.shipList addObject:tModel];
//            }
//            [self.tableView reloadData];
//        }
//        else
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Login Fail", nil) message:NSLocalizedString(@"Please input correct username and password", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
//            [alert show];
//        }
//    }
//    else{
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
//        [alert show];
//    }
//}

@end
