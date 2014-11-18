//
//  HNTemporaryApplyTableViewCell.h
//  edecorate
//
//  Created by 刘向宏 on 14-11-11.
//
//

#import <UIKit/UIKit.h>

@interface HNEditTableViewCell : UITableViewCell

@property (nonatomic, strong)UIButton *photo;
@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)UILabel *title;
- (void)reset;
- (void)setStyle:(NSInteger)flage;
@end
