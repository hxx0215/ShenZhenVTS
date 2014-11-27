//
//  HNHomeHeadView.m
//  ShenZhenVTS
//
//  Created by 刘向宏 on 14-11-15.
//  Copyright (c) 2014年 刘向宏. All rights reserved.
//

#import "HNHomeHeadView.h"

@interface HNHomeHeadView()
@end

@implementation HNHomeHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)init
{
    self = [super init];
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"全部",@"我关注",nil];
    self.segmentView = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    self.segmentView.selectedSegmentIndex = 0;
    
    self.messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.messageButton setImage:[UIImage imageNamed:@"Tab4"] forState:UIControlStateNormal];
    [self.messageButton sizeToFit];
    self.settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.settingButton setImage:[UIImage imageNamed:@"Tab5"] forState:UIControlStateNormal];
    [self.settingButton sizeToFit];
    self.serchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.serchButton setImage:[UIImage imageNamed:@"XXXX"] forState:UIControlStateNormal];
    //[self.serchButton sizeToFit];
    self.serchButton.width = self.settingButton.width;
    self.serchButton.height = self.settingButton.height;
    [self addSubview:self.segmentView];
    [self addSubview:self.messageButton];
    [self addSubview:self.settingButton];
    [self addSubview:self.serchButton];
    return self;
}

-(void)layoutSubviews
{
    self.segmentView.centerY = self.centerY;
    self.segmentView.left = (self.width-self.segmentView.width)/2;
    self.messageButton.centerY = self.centerY;
    self.messageButton.right = self.width -self.settingButton.width - 12;
    self.settingButton.centerY = self.centerY;
    self.settingButton.right = self.width - 12;
    self.serchButton.centerY = self.centerY;
    self.serchButton.left = 12;
}

@end
