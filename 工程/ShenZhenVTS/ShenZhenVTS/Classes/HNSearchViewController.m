//
//  HNSearchViewController.m
//  ShenZhenVTS
//
//  Created by 刘向宏 on 14-11-16.
//  Copyright (c) 2014年 刘向宏. All rights reserved.
//

#import "HNSearchViewController.h"
#import "UIView+AHKit.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import "HNShipDynamicsModel.h"
#import "HNShipDetailViewController.h"

@interface HNSearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UISearchBar* searchBar;
@property(nonatomic,strong) UITableView* tableView;
@property (nonatomic, strong)NSMutableArray *shipList;
@property (nonatomic, strong)NSArray *shipdynamicArray;
@end

@implementation HNSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"艘船";
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 45)];
    self.searchBar.delegate = self;
    self.searchBar.placeholder=@"请输入搜索内容";
    self.searchBar.showsCancelButton = YES;
    [self.view addSubview:self.searchBar];
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.shipList = [[NSMutableArray alloc]init];
    
    self.shipdynamicArray = [NSArray arrayWithObjects:@"shipdynamic是0",@"预抵",@"预离",@"正在抵港",@"正在离港",@"移泊",@"已靠泊",@"已锚泊",@"已离港",@"预抵",@"预抵", nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.searchBar.frame = CGRectMake(0, 0, self.view.width, 45);
    self.tableView.frame = CGRectMake(0, 45, self.view.width, self.view.height-45);
    
}

//search Button clicked....
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar                     // called when keyboard search button pressed
{
    [searchBar resignFirstResponder];
    [self loadMyData];
}
//cancel button clicked...
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar                    // called when cancel button pressed
{
    [searchBar resignFirstResponder];
    
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
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",model.mmsi.integerValue] ;//[self.shipdynamicArray objectAtIndex:model.shipdynamic.integerValue ];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger row = indexPath.row;
    HNShipDetailViewController * vc = [[HNShipDetailViewController alloc]init];
    vc.shipModel = [self.shipList objectAtIndex:row];
    vc.type = KHNUnSee;
    [self.navigationController pushViewController:vc animated:YES];
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
    
    NSString *url = [NSString stringWithFormat:@"http://58.251.165.89:8787/sz-web/plan/ShipController/checkShip?s=%d&e=%d&f=%@",1,100,self.searchBar.text];
    
    request.URL = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
        [self.shipList removeAllObjects];
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",retStr);
        NSArray* array = [retStr objectFromJSONString];
        if ([array count]) {
            for (int i = 0; i<[array count]; i++) {
                NSDictionary *dicData = [array objectAtIndex:i];
                HNShipDynamicsModel *tModel = [[HNShipDynamicsModel alloc] init];
                [tModel updateDataLogin:dicData];
                [self.shipList addObject:tModel];
            }
            
            
        }
        
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"搜索", nil) message:NSLocalizedString(@"没有搜索到船", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
            [alert show];
        }
        [self.tableView reloadData];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
