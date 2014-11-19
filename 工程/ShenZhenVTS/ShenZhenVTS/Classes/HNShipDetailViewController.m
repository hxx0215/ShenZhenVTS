//
//  HNShipDetailViewController.m
//  ShenZhenVTS
//
//  Created by 刘向宏 on 14-11-16.
//  Copyright (c) 2014年 刘向宏. All rights reserved.
//

#import "HNShipDetailViewController.h"
#import "UIView+AHKit.h"
#import "MBProgressHUD.h"
#import "JSONKit.h"
#import "HNUserModel.h"

@interface HNShipDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *arrayTitle;
@property (nonatomic,strong) NSArray *arrayData;
@property (nonatomic,strong) UIButton *seeButton;
@end

@implementation HNShipDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.shipModel.shipname;
    self.tableView = [[UITableView alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    [self initNaviButton];
    
    /*
     1[self setValue:[dic objectForKey:@"callSign"] forKey:@"callsign"];
    2[self setValue:[dic objectForKey:@"cog"] forKey:@"cog"];
    3[self setValue:[dic objectForKey:@"country"] forKey:@"country"];
    4[self setValue:[dic objectForKey:@"destplace"] forKey:@"destplace"];
    5[self setValue:[dic objectForKey:@"draught"] forKey:@"draught"];
    6[self setValue:[dic objectForKey:@"dynamicplace"] forKey:@"dynamicplace"];
    7[self setValue:[dic objectForKey:@"dynamictime"] forKey:@"dynamictime"];
    8[self setValue:[dic objectForKey:@"heading"] forKey:@"heading"];
    9[self setValue:[dic objectForKey:@"imo"] forKey:@"imo"];
    10[self setValue:[dic objectForKey:@"lat"] forKey:@"lat"];
    11[self setValue:[dic objectForKey:@"lon"] forKey:@"lon"];
    12[self setValue:[dic objectForKey:@"mmsi"] forKey:@"mmsi"];
    13[self setValue:[dic objectForKey:@"shipLength"] forKey:@"shipLength"];
    14[self setValue:[dic objectForKey:@"shipName"] forKey:@"shipname"];
    15[self setValue:[dic objectForKey:@"shipWidth"] forKey:@"shipWidth"];
    16[self setValue:[dic objectForKey:@"shipdynamic"] forKey:@"shipdynamic"];
    17[self setValue:[dic objectForKey:@"sog"] forKey:@"sog"];
    18[self setValue:[dic objectForKey:@"status"] forKey:@"status"];
    19[self setValue:[dic objectForKey:@"type"] forKey:@"type"];
    */
    //self.arrayTitle = [NSArray arrayWithObjects:@"callSign:",@"cog:",@"country:",@"destplace:",@"draught:",@"dynamicplace:",@"dynamictime:",@"heading:",@"imo:",@"lat:",@"lon:",@"mmsi:",@"shipLength:",@"shipName:",@"shipWidth:" ,@"shipdynamic:",@"sog:",@"status:" ,@"type:", nil];
    self.arrayTitle = [NSArray arrayWithObjects:@"船呼号:",@"对地航向:",@"国籍:",@"目的地:",@"吃水量:",@"动态位置:",@"动态时间:",@"真航向:",@"imo:",@"纬度:",@"经度:",@"mmsi:",@"船长:",@"船舶名字:",@"船宽:" ,@"动态:",@"对地航速:",@"航行状态:" ,@"船舶类型:", nil];
    
}


- (void)initNaviButton{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"定位" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showButton_Clicked) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor colorWithRed:144.0/255.0 green:197.0/255.0 blue:31.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btn sizeToFit];
    
    self.seeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.seeButton setTitle:@"取消关注" forState:UIControlStateNormal];
    [self.seeButton addTarget:self action:@selector(seeButton_Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.seeButton sizeToFit];
    [self.seeButton setTitleColor:[UIColor colorWithRed:144.0/255.0 green:197.0/255.0 blue:31.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    NSArray *array = [[NSArray alloc]initWithObjects:[[UIBarButtonItem alloc] initWithCustomView:self.seeButton],[[UIBarButtonItem alloc] initWithCustomView:btn], nil ];
    self.navigationItem.rightBarButtonItems = array;
}

-(void)seeButtonChang
{
    if (self.type == KHNSee) {
        [self.seeButton setTitle:@"取消关注" forState:UIControlStateNormal];
    }
    else
    {
        [self.seeButton setTitle:@"关注" forState:UIControlStateNormal];
    }
}

-(void)showButton_Clicked
{
}

-(void)seeButton_Clicked
{
    if (![HNUserDate shared].userID) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Fail", nil) message:NSLocalizedString(@"Please Login", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
        return;
    }
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://202.104.126.36:8787/sz-web/plan/ShipController/focusShip?type=%d&userid=%@&mmsi=%@",self.type==KHNSee?2:1,[HNUserDate shared].userID,self.shipModel.mmsi]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [self performSelectorOnMainThread:@selector(didSee:) withObject:data waitUntilDone:YES];
    }];
}

- (void)didSee:(NSData *)data
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (data)
    {
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",retStr);
        
        if ([retStr isEqualToString:@"true"]){//之后需要替换成status
            self.type = self.type?KHNSee:KHNUnSee;
            [self seeButtonChang];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Fail", nil) message:NSLocalizedString(@"Please Check", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
            [alert show];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
    [self seeButtonChang];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadMyData];
    //
    
}

#pragma mark -loadData
-(void)loadMyData
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://202.104.126.36:8787/sz-web/plan/ShipController/getShipDynamic?mmsi=%ld",self.shipModel.mmsi.integerValue]];
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
        if (1) {
            [self.shipModel updateDetailData:dic];
            [self.tableView reloadData];
        }
        
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Serach", nil) message:NSLocalizedString(@"NO Ship", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
            [alert show];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }
}

#pragma mark - tableView Delegate & DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 19;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"ArchivesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier];
    }
    cell.textLabel.text = [self.arrayTitle objectAtIndex:indexPath.row];
    //cell.textLabel.textColor = [UIColor darkTextColor];
    
    NSArray* shipdynamicArray = [NSArray arrayWithObjects:@"test",@"预抵",@"预离",@"正在抵港",@"正在离港",@"移泊",@"已靠泊",@"已锚泊",@"已离港",@"预抵",@"预抵", nil];
    
    switch (indexPath.row) {
        case 0:
            cell.detailTextLabel.text = self.shipModel.callsign;
            break;
        case 1:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f",self.shipModel.cog.floatValue];
            break;
        case 2:
            cell.detailTextLabel.text = self.shipModel.country;
            break;
        case 3:
            cell.detailTextLabel.text = self.shipModel.destplace;
            break;
        case 4:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f",self.shipModel.draught.floatValue];
            break;
        case 5:
            cell.detailTextLabel.text = self.shipModel.dynamicplace;
            break;
        case 6:
        {
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.shipModel.dynamictime.integerValue/1000];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
            cell.detailTextLabel.text = [dateFormatter stringFromDate:date] ;
        }
            break;
        case 7:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",self.shipModel.heading.intValue];
            break;
        case 8:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",self.shipModel.imo.intValue];
            break;
        case 9:
        {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f",self.shipModel.lat.floatValue];
            
        }
            break;
        case 10:
        {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f",self.shipModel.lon.floatValue];
            
        }
            break;
        case 11:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",self.shipModel.mmsi.intValue];
            break;
        case 12:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",self.shipModel.shipLength.intValue];
            break;
        case 13:
            cell.detailTextLabel.text = self.shipModel.shipname;
            break;
        case 14:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f",self.shipModel.shipWidth.floatValue];
            break;
        case 15:
            cell.detailTextLabel.text = [shipdynamicArray objectAtIndex:self.shipModel.shipdynamic.integerValue];
            break;
        case 16:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f",self.shipModel.sog.floatValue];
            break;
        case 17:
            cell.detailTextLabel.text = self.shipModel.status;
            break;
        case 18:
            cell.detailTextLabel.text = self.shipModel.type;
            break;
            
            
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger row = indexPath.row;

    //    HNArchivesDecorateModel* model = self.modelList[row];
    //    {
    //        HNArchivesListViewController* dac = [[HNArchivesListViewController alloc]init];
    //        dac.dID = model.declareId;
    //        [self.navigationController pushViewController:dac animated:YES];
    //    }
    
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
