//
//  CustomPickerView.m
//  eCamera
//
//  Created by wsg on 2017/4/18.
//  Copyright © 2017年 wsg. All rights reserved.
//

#import "CustomPickerView.h"

#define itemHeight 50
@interface CustomPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,assign)NSInteger indexOne;
@property (nonatomic,assign)NSInteger indexTwo;

@end

@implementation CustomPickerView{
    UIButton *upButton;
    UIButton *downButton;
    UIPickerView *picker;
    NSArray *dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self performSelector:@selector(initPickerView)];
    }
    return self;
}
/**
 *  初始化 选择器
 */
-(void)initPickerView{
    CGAffineTransform rotate = CGAffineTransformMakeRotation(-M_PI/2);
    rotate = CGAffineTransformScale(rotate, 0.1, 1);
    //旋转 -π/2角度
    picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.height*10, self.frame.size.width)];
    
    [picker setTag: 10086];
    picker.delegate = self;
    picker.dataSource = self;
    picker.showsSelectionIndicator = false;
    [picker setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-1.5, (self.frame.size.height- 60)/2, 3, 60)];
    imageV.image = [UIImage imageNamed:@"PTZMiddleLine"];
    UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
    [bgV addSubview:picker];
    [bgV addSubview:imageV];
    [self addSubview:bgV];
    [picker setTransform:rotate];
    picker.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    
}
/**
 *  pickerView代理方法
 *
 *  @param component
 *
 *  @return pickerView有多少个元素
 */
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [dataArray count];
}
/**
 *  pickerView代理方法
 *
 *  @return pickerView 有多少列
 */
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
/**
 *  pickerView代理方法
 *
 *  @param row
 *  @param component
 *  @param view
 *
 *  @return 每个 item 显示的 视图
 */
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    CGAffineTransform rotateItem = CGAffineTransformMakeRotation(M_PI/2);
    rotateItem = CGAffineTransformScale(rotateItem, 1, 10);
    
    CGFloat width = self.frame.size.height;
    
    UIView *itemView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, width-40, 50)];
    UIImageView *itemImgLeft;
    UIImageView *itemImgRight;
    if (row == 0) {
        itemImgLeft = [[UIImageView alloc]initWithFrame:CGRectMake(-0.5, (itemHeight -20)/2, 1, 20)];
        itemImgRight = [[UIImageView alloc]initWithFrame:CGRectMake(width-40-0., (itemHeight -20)/2, 1, 20)];
    }else if(row == self.dataModel.count-1){
        itemImgLeft = [[UIImageView alloc]initWithFrame:CGRectMake(-1, (itemHeight -20)/2, 1, 20)];
        itemImgRight = [[UIImageView alloc]initWithFrame:CGRectMake(width-40-0.5, (itemHeight -21)/2, 1, 20)];
    }else{
        itemImgLeft = [[UIImageView alloc]initWithFrame:CGRectMake(-1.1, (itemHeight -20)/2, 1, 20)];
        itemImgRight = [[UIImageView alloc]initWithFrame:CGRectMake(width-40+0.25, (itemHeight -20)/2, 1, 20)];
    }
    itemImgLeft.image = [UIImage imageNamed:@"PTZThinLine"];
    itemImgRight.image = [UIImage imageNamed:@"PTZThinLine"];
    [itemView addSubview:itemImgLeft];
    [itemView addSubview:itemImgRight];
//    UIImageView *itemImgLeft = [[UIImageView alloc]initWithFrame:CGRectMake(19.5, 0, 1, 20)];
//    itemImgLeft.image = [UIImage imageNamed:@"PTZThinLine"];
//    UIImageView *itemImgRight = [[UIImageView alloc]initWithFrame:CGRectMake(width-20.5, 0, 1, 20)];
//    itemImgRight.image = [UIImage imageNamed:@"PTZThinLine"];
    
    UIImageView *itemImgMiddle = [[UIImageView alloc]initWithFrame:CGRectMake((width-40)/2-1.5, (itemHeight -30)/2, 3, 30)];
    itemImgMiddle.image = [UIImage imageNamed:@"PTZThickLine"];
    [itemView addSubview:itemImgMiddle];

    itemView.transform = rotateItem;
    return itemView;
}

/**
 *  pickerVie代理方法
 *
 *  @param component
 *
 *  @return 每个item的宽度
 */
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component __TVOS_PROHIBITED{
    return self.frame.size.height;
}
/**
 *  pickerView代理方法
 *
 *  @param component
 *
 *  @return 每个item的高度
 */
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return itemHeight;
}
/**
 *  数据源 Setter 方法
 *
 *  @param dataModel 数据数组
 */
-(void)setDataModel:(NSArray *)dataModel{
    dataArray = dataModel;
    [picker reloadAllComponents];
}

/**
 *  数据源 Getter 方法
 *
 *  @return 数据数组
 */
-(NSArray *)dataModel{
    return dataArray;
}

/**
 *  pickerView滑动到指定位置
 *
 *  @param scrollToIndex 指定位置
 */
-(void)scrollToIndex:(NSInteger)scrollToIndex{
    [picker selectRow:scrollToIndex inComponent:0 animated:true];
}
/**
 *  查询当前选择元素Getter方法
 *
 *  @return pickerView当前选择元素 （index：选择位置  name：元素名称）
 */
-(NSDictionary *)selectedItem{
    NSInteger index = [picker selectedRowInComponent:0];
    NSString *contaxt = dataArray[index];
    return @{@"name":contaxt,@"index":[NSString stringWithFormat:@"%ld",index]};
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self.delegate pickerView:pickerView didSelectRow:row];
}



@end
