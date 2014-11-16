//
//  HNShipDetailViewController.m
//  ShenZhenVTS
//
//  Created by 刘向宏 on 14-11-16.
//  Copyright (c) 2014年 刘向宏. All rights reserved.
//

#import "HNShipDetailViewController.h"
#import "UIView+AHKit.h"

@interface HNShipDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *arrayTitle;
@property (nonatomic,strong) NSArray *arrayData;
@end

@implementation HNShipDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.shipModel.shipname_cn;
    self.tableView = [[UITableView alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    
    
    //{"destplace":"大铲湾2","draught":0,"dynamictime":1415871734000,"etx":0,"fromplace":"大铲湾2","shipdynamic":1,"shiplength":1.3912974E7,"shipname_cn":"冷鑫","shiptype":"货船","shipwidth":7907816,"vestid":129}
    self.arrayTitle = [NSArray arrayWithObjects:@"destplace:",@"draught:",@"dynamictime:",@"etx:",@"fromplace:",@"shipdynamic:",@"shiplength:",@"shipname_cn:",@"shiptype:",@"shipwidth:",@"vestid:", nil];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView Delegate & DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"ArchivesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier];
    }
    cell.textLabel.text = [self.arrayTitle objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor darkTextColor];
    
    NSArray* shipdynamicArray = [NSArray arrayWithObjects:@"test",@"预抵",@"预离",@"正在抵港",@"正在离港",@"移泊",@"已靠泊",@"已锚泊",@"已离港",@"预抵",@"预抵", nil];
    
    switch (indexPath.row) {
        case 0:
            cell.detailTextLabel.text = self.shipModel.destplace;
            break;
        case 1:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",self.shipModel.draught.intValue];
            break;
        case 2:
        {
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.shipModel.dynamictime.integerValue/1000];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
            cell.detailTextLabel.text = [dateFormatter stringFromDate:date] ;
        }
            break;
        case 3:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",self.shipModel.etx.integerValue];
            break;
        case 4:
            cell.detailTextLabel.text = self.shipModel.fromplace;
            break;
        case 5:
            cell.detailTextLabel.text = [shipdynamicArray objectAtIndex:self.shipModel.shipdynamic.integerValue];
            break;
        case 6:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",self.shipModel.shiplength.integerValue];
            break;
        case 7:
            cell.detailTextLabel.text = self.shipModel.shipname_cn;
            break;
        case 8:
            cell.detailTextLabel.text = self.shipModel.shiptype;
            break;
        case 9:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",self.shipModel.shipwidth.integerValue];
            break;
        case 10:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",self.shipModel.vestid.intValue];
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
