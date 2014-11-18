//
//  HNRegisterViewController.m
//  ShenZhenVTS
//
//  Created by 刘向宏 on 14-11-18.
//  Copyright (c) 2014年 刘向宏. All rights reserved.
//

#import "HNRegisterViewController.h"
#import "UIView+AHKit.h"
#import "HNEditTableViewCell.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"

@interface HNRegisterViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray* titleArray;
@property (nonatomic, strong) NSArray* pArray;
@property (nonatomic, strong) NSString* btnString;
@end

@implementation HNRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    
    switch (self.type) {
        case KHNRegister:
        {
            self.titleArray = [NSArray arrayWithObjects:@"手机号：",@"验证码：",@"昵称：",@"密码：",@"确认密码：", nil];
            self.pArray = [NSArray arrayWithObjects:@"在此输入手机号",@"输入验证码",@"选填",@"在此输入密码",@"确认密码", nil];
            self.btnString = NSLocalizedString(@"Register", nil);
            self.userModel = [[HNUserModel alloc]init];
        }
            break;
        case KHNForgetPW:
        {
            self.titleArray = [NSArray arrayWithObjects:@"手机号：",@"验证码：",@"密码：",@"确认密码：", nil];
            self.pArray = [NSArray arrayWithObjects:@"在此输入手机号",@"输入验证码",@"在此输入密码",@"确认密码", nil];
            self.btnString = NSLocalizedString(@"Forget Password?", nil);
            self.userModel = [[HNUserModel alloc]init];
        }
            break;
        case KHNModifPW:
        {
            self.titleArray = [NSArray arrayWithObjects:@"旧密码：",@"密码：",@"确认密码：", nil];
            self.pArray = [NSArray arrayWithObjects:@"输入旧密码",@"在此输入密码",@"确认密码", nil];
            self.btnString = NSLocalizedString(@"修改密码", nil);
            self.userModel = [[HNUserModel alloc]init];
        }
            break;
            
        default:
            break;
    }
    self.navigationItem.title = self.btnString;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)commit:(id)sender
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:@"http://202.104.126.36:8787/sz-web/plan/ShipController/saveMobileUser"];
    [request setHTTPMethod:@"POST"];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:self.userModel.username forKey:@"username"];
    [dic setValue:self.userModel.password forKey:@"password"];
    [dic setValue:self.userModel.phonenum forKey:@"phonenum"];
    
    switch (self.type) {
        case KHNRegister:
        {
            
        }
            break;
        case KHNForgetPW:
        {
            [dic setValue:[NSNumber numberWithInteger:[HNUserDate shared].userID.integerValue] forKey:@"id"];
        }
            break;
        case KHNModifPW:
        {
            [dic setValue:[NSNumber numberWithInteger:[HNUserDate shared].userID.integerValue] forKey:@"id"];
        }
            break;
            
        default:
            break;
    }
    NSLog(@"%@",[dic JSONString]);
    NSData *postData = [[dic JSONString] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [request setHTTPBody:postData];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSString *postLength = [NSString stringWithFormat:@"%ld",[postData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
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
        
        if (1){
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

#pragma mark - textField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (self.type) {
        case KHNRegister:
        {
            switch (textField.tag) {
                case 0:
                {
                    self.userModel.phonenum = textField.text;
                }
                    break;
                case 1:
                {
                    //self.userModel.phonenum = textField.text;
                }
                    break;
                case 2:
                {
                    self.userModel.username = textField.text;
                }
                    break;
                case 3:
                {
                    self.userModel.password = textField.text;
                }
                    break;
                case 4:
                {
                    self.userModel.repassword = textField.text;
                }
                    break;
                    
                default:
                    break;
            };
        }
            break;
        case KHNForgetPW:
        {
            switch (textField.tag) {
                case 0:
                {
                    self.userModel.phonenum = textField.text;
                }
                    break;
                case 1:
                {
                    //self.userModel.phonenum = textField.text;
                }
                    break;
                case 2:
                {
                    self.userModel.password = textField.text;
                }
                    break;
                case 3:
                {
                    self.userModel.repassword = textField.text;
                }
                    break;
                    
                default:
                    break;
            };
        }
            break;
        case KHNModifPW:
        {
            switch (textField.tag) {
                case 0:
                {
                    self.userModel.phonenum = textField.text;
                }
                    break;
                case 1:
                {
                    self.userModel.oldpassword = textField.text;
                }
                    break;
                case 2:
                {
                    self.userModel.password = textField.text;
                }
                    break;
                case 3:
                {
                    self.userModel.repassword = textField.text;
                }
                    break;
                    
                default:
                    break;
            };
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0==section)
    {
        return [self.titleArray count];
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
        label.text = @"用户信息";
        [label sizeToFit];
        label.textColor = [UIColor whiteColor];
        label.left = 5;
        label.centerY = contentView.height / 2;
        [contentView addSubview:label];
        
    }
    else
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:self.btnString forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
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
    HNEditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell)
    {
        cell = [[HNEditTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identy];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor darkTextColor];
    cell.title.text = [self.titleArray objectAtIndex:indexPath.row];
    cell.textField.placeholder = [self.pArray objectAtIndex:indexPath.row];
    cell.textField.tag = indexPath.row;
    cell.textField.delegate = self;
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
