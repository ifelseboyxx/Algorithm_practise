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

// ## 选择排序优化
// 在每一轮中, 可以同时找到当前未处理元素的最大值和最小值
void selectionSort2(int arr[], int n) {
    
    int left = 0, right = n - 1;
    while(left < right){
        int minIndex = left;
        int maxIndex = right;
        
        // 在每一轮查找时, 要保证arr[minIndex] <= arr[maxIndex]
        if(arr[minIndex] > arr[maxIndex]) {
            swap(arr[minIndex], arr[maxIndex]);
        }
        
        for(int i = left + 1 ; i < right; i ++) {
            if(arr[i] < arr[minIndex]) {
                minIndex = i;
            }else if(arr[i] > arr[maxIndex])
                maxIndex = i;
        }
        
        swap(arr[left], arr[minIndex]);
        swap(arr[right], arr[maxIndex]);
        
        left ++;
        right --;
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
        
        int n = 20000;
        int *arr = SortTestHelper::generateRandomArray(n,0,n);
        int *arr2 = SortTestHelper::copyIntArray(arr, n);
        
        SortTestHelper::testSort("选择排序", selectionSort, arr, n);
        SortTestHelper::testSort("选择排序优化", selectionSortX, arr2, n);
        
        
        delete[] arr;
        delete[] arr2;
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
