//
//  FooterButtonView.h
//  Doctor
//
//  Created by 张良玉 on 2018/11/22.
//  Copyright © 2018年 zhangliangyu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FooterButtonViewHeight (kGetWidth(55))
#define FooterButtonHeight (kGetWidth(44))
#define FooterButtonViewFactsHeight (FooterButtonViewHeight+kSafeAreaHeight)

#define FooterButtonColor RGB_COLOR_WITH_0x(0x4679f8)
#define FooterButtonTitleColor RGB_COLOR_WITH_0x(kWhiteColor)
#define FooterButtonFont kSystemFitFont(15)
@interface FooterButtonView : UIView

@end
