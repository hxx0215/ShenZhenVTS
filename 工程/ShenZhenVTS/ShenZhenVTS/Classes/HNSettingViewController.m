//
//  HNSettingViewController.m
//  ShenZhenVTS
//
//  Created by 刘向宏 on 14-11-16.
//  Copyright (c) 2014年 刘向宏. All rights reserved.
//

#import "HNSettingViewController.h"
#import "UIView+AHKit.h"
#import "HNUserModel.h"

@interface HNSettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray* titleArray;
@property (nonatomic, strong) NSArray* dtailArray;
@property (nonatomic, strong) HNUserDate* userDate;
@end

@implementation HNSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"个人中心";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.userDate = [HNUserDate shared];
    self.titleArray = [NSArray arrayWithObjects:@"手机号：",@"昵称：",@"修改密码",@"清除缓存", nil];
    self.dtailArray = [NSArray arrayWithObjects:self.userDate.phonenum,self.userDate.username,@" ",@" ", nil];
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    return NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0==section)
    {
        return 4;
    }
    else
        return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 55)];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, tableView.width - 20, 50)];
    if (section==0) {
        contentView.backgroundColor = [UIColor colorWithRed:144.0/255.0 green:197.0/255.0 blue:31.0/255.0 alpha:1.0];
    }
    else
    {
        contentView.backgroundColor = [UIColor colorWithRed:1.0 green:85.0/255.0 blue:0 alpha:1.0];
        contentView.layer.cornerRadius = 7;
        contentView.layer.borderWidth = 0;
        contentView.layer.borderColor = [[UIColor grayColor] CGColor];
        contentView.layer.masksToBounds = YES;
    }
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(7, 7)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = contentView.bounds;
    maskLayer.path = maskPath.CGPath;
    contentView.layer.mask = maskLayer;
    
    
    if (section == 0){
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15];
        label.width = contentView.width -10;
        label.numberOfLines = 2;
        label.text = @"个人信息";
        [label sizeToFit];
        label.textColor = [UIColor whiteColor];
        label.left = 5;
        label.centerY = contentView.height / 2;
        [contentView addSubview:label];
        
    }
    else
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"注销" forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, contentView.width, contentView.height);
        [contentView addSubview:btn];
    }
    [view addSubview:contentView];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0==indexPath.section)
    {
        
        return 30;
    }
    else
        return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identy = @"complaintDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identy];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor darkTextColor];
    cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    if ([self.dtailArray count]>indexPath.row) {
        cell.detailTextLabel.text = [self.dtailArray objectAtIndex:indexPath.row];
    }
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == self.tableView) {
            CGFloat cornerRadius = 7.f;
            cell.backgroundColor = UIColor.clearColor;
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = CGRectInset(cell.bounds, 10, 0);
            BOOL addLine = NO;
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
                /*} else if (indexPath.row == 0) {
                 CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                 CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                 CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                 CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                 addLine = YES;*/
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            } else {
                CGPathAddRect(pathRef, nil, bounds);
                addLine = YES;
            }
            layer.path = pathRef;
            CFRelease(pathRef);
            layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
            
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
                [layer addSublayer:lineLayer];
            }
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            
            [testView.layer insertSublayer:layer atIndex:0];
            testView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = testView;
            
        }
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
