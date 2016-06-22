//
//  ViewController.m
//  AlgorithmDemo
//
//  Created by 付金诗 on 16/6/22.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import "ViewController.h"
#define kCount 10000
#define kMaxNumber 20000
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)NSMutableArray * sortArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"基本算法总结";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"name"];
    [self.view addSubview:self.tableView];
    
    self.dataArray = [NSMutableArray arrayWithObjects:@"冒泡排序  Bubble Sort",@"选择排序 selection sort",@"快速排序法  Divide and conquer",@"直接插入排序 Insertion Sort", nil];

    [self resertArray];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(resertArray)];
    
    /*
     1w个数字排序
     冒泡排序 >>>>>>>>>>cost time = 3120.547056 ms
     选择排序>>>>>>>>>>cost time = 2905.982018 ms
     快速排序 >>>>>>>>>>cost time = 7.151008 ms 是冒泡排序的445倍
     直接插入排序>>>>>>>>>>cost time = 1519.446015 ms
     */
}

#pragma mark -- 充值排序数组
- (void)resertArray
{
    self.sortArray = [NSMutableArray array];
    for (NSInteger i = 0; i < kCount; i++) {
        NSInteger number = arc4random() % kMaxNumber;
        [self.sortArray addObject:[NSNumber numberWithInteger:number]];
    }
    
    NSString * string = [self.sortArray componentsJoinedByString:@","];
    
//    NSLog(@"%@",string);
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"name" forIndexPath:indexPath];
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //异步处理,为了在数量过大的时候依然可以正常运行,而不会阻塞主线程.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"我点击了第%ld个item",indexPath.row);
        NSMutableArray * sortArray = [NSMutableArray arrayWithArray:self.sortArray];
        NSDate* tmpStartData = [NSDate date];
        switch (indexPath.row) {
            case 0:
            {
                //冒泡排序
                [self bubbleSortWithDataArray:sortArray];
            }
                break;
            case 1:
            {
                //选择排序
                [self selectionSortWithDataArray:sortArray];
            }
                break;
            case 2:
            {
                //快速排序
                [self quickSortWithDataArray:sortArray leftIndex:0 rightIndex:sortArray.count - 1];
            }
                break;
            case 3:
            {
                //插入排序
                [self insertionSortWithDataArray:sortArray];
                
            }
                break;
            default:
                break;
        }
        double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
        NSLog(@">>>>>>>>>>cost time = %f ms", deltaTime*1000);
        NSString * string = [sortArray componentsJoinedByString:@","];
        //在数量过大的时候 不要打开log
        //    NSLog(@"%@",string);
    });

    
    
}


#pragma mark -- 冒泡排序  Bubble Sort
/*
 冒泡排序算法的运作如下：
 1.比较相邻的元素。如果第一个比第二个大，就交换他们两个。
 2.对每一对相邻元素作同样的工作，从开始第一对到结尾的最后一对。在这一点，最后的元素应该会是最大的数。
 3.针对所有的元素重复以上的步骤，除了最后一个。
 持续每次对越来越少的元素重复上面的步骤，直到没有任何一对数字需要比较。
 */
- (void)bubbleSortWithDataArray:(NSMutableArray *)dataArray
{
    for (NSInteger i = 0; i < dataArray.count; i++) {
        //每次循环一次下面的,就可以找到最末尾的一个数字,所以在之后的循环中,可以减少点确定的数字的循环次数 dataArray.count - i - 1
        for (NSInteger j = 0; j < dataArray.count - i - 1; j++) {
            if ([dataArray objectAtIndex:j] > [dataArray objectAtIndex:j + 1]) {
                NSNumber * temp = [dataArray objectAtIndex:j];
                [dataArray replaceObjectAtIndex:j withObject:[dataArray objectAtIndex:j + 1]];
                [dataArray replaceObjectAtIndex:j + 1 withObject:temp];
            }
        }
    }
}





#pragma mark -- 选择排序
/*
 工作原理：首先在未排序序列中找到最小元素，存放到排序列的起始位置，然后，再从剩余未排序元素中继续寻找最小元素，然后放到排序序列末尾。依次类推，直到所有元素均排序完毕。
 */
- (void)selectionSortWithDataArray:(NSMutableArray *)array
{
    for (NSInteger i = 0; i < array.count; i++) {
        for (NSInteger j = i + 1; j < array.count; j++) {
            if ([array objectAtIndex:i] > [array objectAtIndex:j]) {
                NSNumber * temp = [array objectAtIndex:i];
                [array replaceObjectAtIndex:i withObject:[array objectAtIndex:j]];
                [array replaceObjectAtIndex:j withObject:temp];
            }
        }
    }
}








#pragma mark -- 快速排序法  采取左侧第一个元素为piovt 双向算法
/*
     快 速排序是由东尼·霍尔所发展的一种排序算法。在平均状况下，排序 n 个项目要Ο(n log n)次比较。在最坏状况下则需要Ο(n2)次比较，但这种状况并不常见。事实上，快速排序通常明显比其他Ο(n log n) 算法更快，因为它的内部循环（inner loop）可以在大部分的架构上很有效率地被实现出来。
     快速排序使用分治法（Divide and conquer）策略来把一个串行（list）分为两个子串行（sub-lists）。
     算法步骤：
     1 从数列中挑出一个元素，称为 “基准”（pivot），
     2 重新排序数列，所有元素比基准值小的摆放在基准前面，所有元素比基准值大的摆在基准的后面（相同的数可以到任一边）。在这个分区退出之后，该基准就处于数列的中间位置。这个称为分区（partition）操作。
     3 递归地（recursive）把小于基准值元素的子数列和大于基准值元素的子数列排序。
     递归的最底部情形，是数列的大小是零或一，也就是永远都已经被排序好了。虽然一直递归下去，但是这个算法总会退出，因为在每次的迭代（iteration）中，它至少会把一个元素摆到它最后的位置去。
 */
- (void)quickSortWithDataArray:(NSMutableArray *)array  leftIndex:(NSInteger)left rightIndex:(NSInteger)right
{
    //当左侧数组中只有一个元素或者没有元素的时候,结束递归. 也就是leftIndex 始终等于 0,如果最后数组中只有一个元素那么 rightIndex = 0 则结束
    if (left >= right) {
        return;
    }
    
    NSInteger leftIndex = left;
    NSInteger rightIndex = right;
    NSNumber * pivot = [array objectAtIndex:leftIndex];
    
    while (leftIndex < rightIndex) {
        
        while (leftIndex < rightIndex && [array objectAtIndex:rightIndex] >= pivot) {
            rightIndex = rightIndex - 1;
        }
        //找到了右侧数组中小于标准的一个之后,将它移动到leftIndex的位置.
        [array replaceObjectAtIndex:leftIndex withObject:[array objectAtIndex:rightIndex]];
        
        while (leftIndex < rightIndex && [array objectAtIndex:leftIndex] <= pivot) {
            leftIndex = leftIndex + 1;
        }
        
        [array replaceObjectAtIndex:rightIndex withObject:[array objectAtIndex:leftIndex]];
    }
    
    [array replaceObjectAtIndex:leftIndex withObject:pivot];
    
    [self quickSortWithDataArray:array leftIndex:left rightIndex:leftIndex - 1];
    
    [self quickSortWithDataArray:array leftIndex:leftIndex + 1 rightIndex:right];
    
}


#pragma mark -- 直接插入排序   Insertion Sort
/*
 直接插入排序(Insertion Sort)的基本思想是：每次将一个待排序的记录，按其关键字大小插入到前面已经排好序的子序列中的适当位置，直到全部记录插入完成为止。
 
 设数组为a[0…n-1]。
 
 1. 初始时，a[0]自成1个有序区，无序区为a[1..n-1]。令i=1
 
 2. 将a[i]并入当前的有序区a[0…i-1]中形成a[0…i]的有序区间。
 
 3. i++并重复第二步直到i==n-1。排序完成。
 */

- (void)insertionSortWithDataArray:(NSMutableArray *)dataArray
{
    for (NSInteger i = 1; i < dataArray.count; i++) {
        for (NSInteger j = 0; j < i; j++) {
            if ([dataArray objectAtIndex:i] < [dataArray objectAtIndex:j]) {
                //找到了自己正确的位置之后,就开始插入
                [dataArray insertObject:[dataArray objectAtIndex:i] atIndex:j];
                //插入之后要将原来的数字删除.
                [dataArray removeObjectAtIndex:i + 1];
            }
        }
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
