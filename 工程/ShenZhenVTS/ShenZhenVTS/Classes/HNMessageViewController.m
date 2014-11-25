//
//  HNMessageViewController.m
//  ShenZhenVTS
//
//  Created by 刘向宏 on 14-11-16.
//  Copyright (c) 2014年 刘向宏. All rights reserved.
//

#import "HNMessageViewController.h"
#import "MBProgressHUD.h"
#import "HNMessageData.h"
#import "JSONKit.h"
#import "UIView+AHKit.h"

@interface HNMessageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HNMessageData *messageData;
@property (nonatomic,strong) UILabel *lable;
@end

@implementation HNMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"防台信息";
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.lable = [[UILabel alloc]init];
    [self.tableView addSubview:self.lable];
    self.lable.width = self.view.width-60;
    self.lable.left = 30;
    self.lable.top = 45*3+30;
    self.lable.font = [UIFont systemFontOfSize:15];
    self.lable.numberOfLines = 0;
    
    self.messageData = [[HNMessageData alloc]init];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
    [self loadMyData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView Delegate & DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==3) {
        return self.view.height - 45*3;
    }
    return 45.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"ArchivesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier];
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"台风编号:";
            cell.detailTextLabel.text = self.messageData.code;
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"台风名称:";
            cell.detailTextLabel.text = self.messageData.name;
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"台风时间:";
            
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.messageData.deloytime.doubleValue/1000];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
            cell.detailTextLabel.text = [dateFormatter stringFromDate:date] ;
        }
            break;
//        case 3:
//        {
//            cell.textLabel.text = @"备注信息";
//            cell.detailTextLabel.text = @"sadasadddddasssssdadad\nasd\nadad\nadad\n";//self.messageData.des;
//        }
//            break;
            
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    NSInteger row = indexPath.row;
//    HNShipDetailViewController * vc = [[HNShipDetailViewController alloc]init];
//    vc.shipModel = [self.shipList objectAtIndex:row];
//    [self.navigationController pushViewController:vc animated:YES];
    //    HNArchivesDecorateModel* model = self.modelList[row];
    //    {
    //        HNArchivesListViewController* dac = [[HNArchivesListViewController alloc]init];
    //        dac.dID = model.declareId;
    //        [self.navigationController pushViewController:dac animated:YES];
    //    }
    
}

#pragma mark -loadData
-(void)loadMyData
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    
    request.URL = [NSURL URLWithString:@"http://202.104.126.36:8787/sz-web/plan/TyphoonController/getTyphoonMsg"];
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
        
        [self.messageData updateData:dic];
        [self.tableView reloadData];
        self.lable.text = [NSString stringWithFormat:@"%@", self.messageData.des];
        [self.lable sizeToFit];
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }
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
