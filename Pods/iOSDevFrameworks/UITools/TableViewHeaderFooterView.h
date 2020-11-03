//
//  TableViewHeaderFooterView.h
//  Doctor
//
//  Created by 张良玉 on 16/5/9.
//  Copyright © 2016年 YX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UILabel *subtitleLabel;
@property (nonatomic ,strong) UIView *subtitleView;
@property (nonatomic ,strong) UIView *topLine;
@property (nonatomic ,strong) UIView *bottomLine;
@property (nonatomic ,strong) UIColor *backgroundViewColor;
@property (nonatomic ,strong) NSString *subtitle;
@property (nonatomic ,assign) BOOL nextHidden;
@property (nonatomic ,strong) void(^tapClickBlock)(void);
@property (nonatomic ,strong) UIImageView *nextImageView;
+(id)shareTableHeaderFooterView:(UITableView *)tableView;// reuseIdentifier:(NSString *)reuseIdentifier;
+(id)shareTableHeaderFooterView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;

@end
