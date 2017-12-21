//
//  main.m
//  Algorithm
//
//  Created by Jason on 2017/12/18.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#include <iostream>
#include <algorithm>
#include "SortTestHelper.h"

using namespace std;

// ## 选择排序
// ## 时间复杂度 (n*n)
void selectionSort(int arr[], int n) {
    for (int i = 0; i < n; i++) {
        int minIndex = i; // 定义最小值为 i
        for (int j = i + 1; j < n; j++) { // 第二次循环，从 i + 1，也就是第二个开始
            if (arr[j] < arr[minIndex]) { // 比较大小
                minIndex = j; // 更新最小值得 index
            }
        }
        swap(arr[minIndex], arr[i]); // 交换
    }
}


#warning 对于一个近乎有序的数组，插入排序的性能效率是非常高的
#warning 当数组几乎有序的话，时间效率是近乎 O(n) 的 ！！！！

// ## 插入排序
// ## 时间复杂度 (n*n)
void insertionSort(int arr[],int n) {
    
    for (int i = 0; i < n; i ++) {
        for (int j = i; j > 0 && arr[j] < arr[j - 1]; j--) { // 依次往 i 的前面元素检查，
            swap(arr[j], arr[j - 1]); // 每次交换，还是比较消耗性能的
        }
    }
}

// ## 插入排序优化
void insertionSort2(int arr[],int n) {
    
    for (int i = 0; i < n; i++) {
        int e = arr[i];
        int j;
        for (j = i; j > 0 && arr[j - 1] > e; j--) {
            arr[j] = arr[j-1];
        }
        arr[j] = e;  // 这里只是简单的赋值， 未优化前，一次交换相当于 3 次赋值
    }
}

#warning  - 冒泡排序 ？ 希尔排序 ？

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        int n = 10000;
        int *arr = SortTestHelper::generateRandomArray(n,0,n);
        int *arr2 = SortTestHelper::copyIntArray(arr, n);
        
        SortTestHelper::testSort("选择排序", selectionSort, arr, n);
        SortTestHelper::testSort("插入排序", insertionSort2, arr2, n);
        
        
        delete[] arr;
        delete[] arr2;
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
