//
//  ViewController.m
//  ZHYMVVMDemo
//
//  Created by 赵宏亚 on 2019/7/15.
//  Copyright © 2019 赵宏亚. All rights reserved.
//

#import "ViewController.h"
#import "ViewModel.h"

@interface ViewController ()

@property (nonatomic,strong) ViewModel *vmModel;
@property (nonatomic,strong) Model *model;
@property (nonatomic,strong) NSMutableArray *modelArray; // 可以用于存储model

@property (weak, nonatomic) IBOutlet UIView *namesView; // 显示名字


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    __weak typeof(self) weakSelf = self;
    self.vmModel = [[ViewModel alloc] initWithBlock:^(Model * _Nonnull model) {
        // 此处接受从后台得到的数据, 里边可以进行刷新UI等一系列操作。
        [weakSelf.modelArray addObject:model];
        weakSelf.model = model; // 进行赋值
        
        NSLog(@"names ****** %@",model.names);
        NSLog(@"数组数量 ****** %lu",(unsigned long)weakSelf.modelArray.count);
        
        
        for (UIView *view in weakSelf.namesView.subviews) {
            [view removeFromSuperview];
        }
        
        // 用于测试双向绑定
        for (int i = 0; i < model.names.count; i ++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50*i, 0, 50, 50)];
            label.text = model.names[i];
            [weakSelf.namesView addSubview:label];
        }
    }];
}


// 触发数据刷新
- (IBAction)refreshClick:(UIButton *)sender {
    // 触发获取数据
    [self.vmModel loadData];
}



- (IBAction)changeNames:(UIButton *)sender {
    
    self.vmModel.changeName = sender.titleLabel.text;
    
}



// 数组懒加载
- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}


@end
