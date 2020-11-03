//
//  UITableViewCell+ShareCell.m
//  Doctor
//
//  Created by 张良玉 on 16/5/6.
//  Copyright © 2016年 YX. All rights reserved.
//

#import "UITableViewCell+ShareCell.h"
#import "UIImage+Tint.h"
#import "ToolsHeader.h"
@implementation UITableViewCell (ShareCell)

+(id)shareCellTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier
{
    return [self shareCellTableView:tableView style:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}

+(id)shareCellTableView:(UITableView *)tableView style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    UITableViewCell *cell = (UITableViewCell *)[self class];
    cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[self class] alloc]initWithStyle:style reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = kSystemFitFont(16);
        cell.textLabel.textColor = RGB_COLOR_WITH_0x(BlackTextColor);
        cell.detailTextLabel.font = kSystemFitFont(16);
    }
    return cell;
}
@end
