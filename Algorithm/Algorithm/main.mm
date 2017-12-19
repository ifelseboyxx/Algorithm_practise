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

// ## 插入排序
// ##
void insertionSort(int arr[],int n) {
    
    for (int i = 0; i < n; i ++) {
        for (int j = i; j > 0 && arr[j] < arr[j - 1]; j--) {
            swap(arr[j], arr[j - 1]);
        }
    }
    
}


int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        int n = 10000;
        int *arr = SortTestHelper::generateRandomArray(n,0,n);
        int *arr2 = SortTestHelper::copyIntArray(arr, n);
        
        SortTestHelper::testSort("选择排序", selectionSort, arr, n);
        SortTestHelper::testSort("插入排序", insertionSort, arr2, n);
        
        
        delete[] arr;
        delete[] arr2;
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
