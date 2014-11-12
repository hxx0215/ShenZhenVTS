//
//  HNLoginView.m
//  edecorate
//
//  Created by hxx on 10/21/14.
//
//

#import "HNLoginView.h"
#import "UIView+AHKit.h"
@interface HNLoginView()
@property (nonatomic, strong)UILabel *userLabel;
@property (nonatomic, strong)UILabel *passwordLabel;
@property (nonatomic, strong)UIView *midline;
@end
@implementation HNLoginView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5.0;
        self.userLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 85, frame.size.height / 2 -1)];
        self.userLabel.text = NSLocalizedString(@"User", nil);
        self.userLabel.textAlignment = NSTextAlignmentRight;
        UIView *sep1 = [self createSeperateLine:CGRectMake(0, 0, 1, 20)];
        sep1.centerY = self.userLabel.centerY;
        sep1.left = self.userLabel.right + 15;
        self.midline = [[UIView alloc] initWithFrame:CGRectMake(0, self.userLabel.height +1, frame.size.width, 1)];
        self.midline.backgroundColor = [UIColor grayColor];
        self.passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.userLabel.height + 2, 85, frame.size.height / 2)];
        self.passwordLabel.text = NSLocalizedString(@"Password", nil);
        self.passwordLabel.textAlignment = NSTextAlignmentRight;
        UIView *sep2 = [self createSeperateLine:CGRectMake(0, 0, 1, 20)];
        sep2.centerY = self.passwordLabel.centerY;
        sep2.left = sep1.left;
        
        self.userName = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.width - sep1.right - 15, self.userLabel.height)];
        self.userName.left = sep1.right + 15;
        self.userName.placeholder = NSLocalizedString(@"User/Email/Mobile", nil);
        
        self.password = [[UITextField alloc] initWithFrame:self.userName.frame];
        self.password.left = self.userName.left;
        self.password.top = self.passwordLabel.top;
        self.password.placeholder = NSLocalizedString(@"Input Password", nil);
        self.password.secureTextEntry = YES;
        [self addSubview:self.userLabel];
        [self addSubview:self.midline];
        [self addSubview:self.passwordLabel];
        [self addSubview:sep1];
        [self addSubview:sep2];
        [self addSubview:self.userName];
        [self addSubview:self.password];
    }
    return self;
}

- (UIView *)createSeperateLine:(CGRect)frame{
    UIView *sep = [[UIView alloc] initWithFrame:frame];
    sep.backgroundColor = [UIColor lightGrayColor];
    return sep;
}
@end
