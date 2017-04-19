//
//  ViewController.m
//  CustomPickerView
//
//  Created by wsg on 2017/4/18.
//  Copyright © 2017年 wsg. All rights reserved.
//

#import "ViewController.h"
#import "CustomPickerView.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()<MyPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *pickerBgView;

@property (strong, nonatomic) CustomPickerView *pickerView;
/**pickerview视图 大背景图*/
@property (weak, nonatomic) UIImageView *pickerBigBg;
/**pickerview视图 齿轮背景*/
@property (weak, nonatomic) UIImageView *pickerBg;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initPickerView];
}

#pragma - mark 初始化pickerView
-(void)initPickerView{
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    CGFloat pk_x = 30;
    CGFloat pk_y = 10;
    _pickerView = [[CustomPickerView alloc]initWithFrame:CGRectMake(pk_x, pk_y, SCREEN_WIDTH-pk_x*2, 110-pk_y*2)];
    _pickerView.delegate = self;
    [_pickerView scrollToIndex:12/2];
    
    UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
    UIImageView * bgImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
    bgImgV.image = [UIImage imageNamed:@"PTZBg"];
    [bgV addSubview:bgImgV];
    [self.pickerBgView addSubview:bgV];
    [self.pickerBgView addSubview:_pickerView];
    for (UIView *subv1 in self.pickerBgView.subviews) {
        if ([subv1 isKindOfClass:[CustomPickerView class]]) {
            for (UIView *subv2 in subv1.subviews) {
                if ([subv2 isKindOfClass:[UIView class]]) {
                    for (UIView *subv3 in subv2.subviews) {
                        if ([subv3 isKindOfClass:[UIPickerView class]]) {
                            for (UIView *subv4 in subv3.subviews) {
                                if (subv4.frame.size.height < 1)//取出分割线view
                                {
                                    //NSLog(@"subv4:%@",subv4);
                                    subv4.hidden = YES;//隐藏分割线
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row{
    NSLog(@"***selectRow: %ld",row);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
