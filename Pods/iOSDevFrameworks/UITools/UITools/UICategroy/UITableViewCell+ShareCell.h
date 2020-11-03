//
//  UITableViewCell+ShareCell.h
//  Doctor
//
//  Created by 张良玉 on 16/5/6.
//  Copyright © 2016年 YX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (ShareCell)

+(id)shareCellTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;
+(id)shareCellTableView:(UITableView *)tableView style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
