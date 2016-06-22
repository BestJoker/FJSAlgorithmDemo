# FJSAlgorithmDemo
OC中常用数组排序Demo  sortDemo AlgorithmDemo  

1.冒泡排序  Bubble Sort                 
 原理:                  
      1.比较相邻的元素。如果第一个比第二个大，就交换他们两个。  
      2.对每一对相邻元素作同样的工作，从开始第一对到结尾的最后一对。在这一点，最后的元素应该会是最大的数。  
      3.针对所有的元素重复以上的步骤，除了最后一个。    
      持续每次对越来越少的元素重复上面的步骤，直到没有任何一对数字需要比较。    

2.选择排序  selection sort      
   原理:首先在未排序序列中找到最小元素，存放到排序列的起始位置，然后，再从剩余未排序元素中继续寻找最小元素，然后放到排序序列末尾。依次类      推，直到所有元素均排序完毕。    

3.快速排序法  Divide and conquer    
   快 速排序是由东尼·霍尔所发展的一种排序算法。在平均状况下，排序 n 个项目要Ο(n log n)次比较。在最坏状况下则需要Ο(n2)次比较，但这种状况并不常见。事实上，快速排序通常明显比其他Ο(n log n) 算法更快，因为它的内部循环（inner loop）可以在大部分的架构上很有效率地被实现出来。   
     快速排序使用分治法（Divide and conquer）策略来把一个串行（list）分为两个子串行（sub-lists）。  
     算法步骤：         
     1 从数列中挑出一个元素，称为 “基准”（pivot）                                
     2 重新排序数列，所有元素比基准值小的摆放在基准前面，所有元素比基准值大的摆在基准的后面（相同的数可以到任一边）。在这个分区退出之后，该基准就处于数列的中间位置。这个称为分区（partition）操作。    
     3 递归地（recursive）把小于基准值元素的子数列和大于基准值元素的子数列排序。    
     递归的最底部情形，是数列的大小是零或一，也就是永远都已经被排序好了。虽然一直递归下去，但是这个算法总会退出，因为在每次的迭代（iteration）中，它至少会把一个元素摆到它最后的位置去。      

4.直接插入排序   Insertion Sort 
    直接插入排序(Insertion Sort)的基本思想是：每次将一个待排序的记录，按其关键字大小插入到前面已经排好序的子序列中的适当位置，直到全部记录插入完成为止。    
    设数组为a[0…n-1]。  
     1. 初始时，a[0]自成1个有序区，无序区为a[1..n-1]。令i=1                     
     2. 将a[i]并入当前的有序区a[0…i-1]中形成a[0…i]的有序区间。  
     3. i++并重复第二步直到i==n-1。排序完成。   
     
     
后续还会继续补充,代码都是自己写的,可能会有一定的问题.   
     




