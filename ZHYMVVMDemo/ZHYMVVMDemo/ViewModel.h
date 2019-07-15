//
//  ViewModel.h
//  ZHYMVVMDemo
//
//  Created by 赵宏亚 on 2019/7/15.
//  Copyright © 2019 赵宏亚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ViewModelBlock)(Model *model);

// 接口接受数据，将接受的数据交由model进行处理，并将处理后的数据交给VC
@interface ViewModel : NSObject

@property (nonatomic,copy) ViewModelBlock vmBlock; // 后台数据传递中介

@property (nonatomic,strong) NSDictionary *changeName; // 移除一个名字

// 通过block进行数据绑定，将获取的数据通过block传递给VC
- (instancetype)initWithBlock:(ViewModelBlock)block;

// VC调取后台加载数据接口
- (void)loadData;

@end

NS_ASSUME_NONNULL_END
