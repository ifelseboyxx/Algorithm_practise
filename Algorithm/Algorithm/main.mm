//
//  main.m
//  Algorithm
//
//  Created by Jason on 2017/12/18.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

// 性能对比分析
//http://blog.csdn.net/li563868273/article/details/51200876


#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#include <iostream>
#include <algorithm>
#include "SortTestHelper.h"

using namespace std;

// ## 选择排序
// ## 时间复杂度 O(n^2)
// ## 不稳定

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
// ## 时间复杂度 O(n^2)
// ## 稳定
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

// ## shell 排序 （缩小增量排序）
// ## 也属于插入排序的一种
// ## 平均时间 O(nlogn) 最差时间O(n^s) 1<s<2
// 不稳定
void shellSort(int arr[], int n){
    
    // 计算 increment sequence: 1, 4, 13, 40, 121, 364, 1093...
    int h = 1;
    while( h < n/3 ) {
        h = 3 * h + 1;
    }
    
    while( h >= 1 ){
        
        // h-sort the array
        for( int i = h ; i < n ; i ++ ){
            // 对 arr[i], arr[i-h], arr[i-2*h], arr[i-3*h]... 使用插入排序
            int e = arr[i];
            int j;
            for( j = i ; j >= h && arr[j-h] > e; j -= h ){
                arr[j] = arr[j-h];
            }
            arr[j] = e;
        }
        
        h = h/3;
    }
}


// ## 冒泡排序
// ## 时间复杂度 O(n^2)
// ## 稳定
#warning 对于完全有序的数组，冒泡排序法也将成为O(n)级别的算法

/**
 在生活中应该也会看到气泡从水里面出来时，越到水面上气泡就会变的越大。在物理上学气压的时候好像也看到过这种现象；其实理解冒泡排序就可以根据这种现象来理解：每一次遍历，都把大的往后面排（当然也可以把小的往后面排），所以每一次都可以把无序中最大的（最小）的元素放到无序的最后面（或者说有序元素的最开始）；
 */
void BubbleSort(int arr[],int n) {
    
    bool swaped;
    do {
        swaped = false;
        for (int i = 1; i < n; i++) {
            if (arr[i-1] > arr[i]) {
                swap(arr[i-1], arr[i]);
                swaped = true;
            }
        }
        n--;
    }while(swaped);
}


// ## 冒泡排序优化
void BubbleSort2(int arr[],int n) {
    
    int newn; // 使用newn进行优化
    
    do {
        newn = 0;
        for (int i = 1; i < n; i++) {
            if (arr[i-1] > arr[i]) {
                swap(arr[i-1], arr[i]);
                
                newn = i;// 记录最后一次的交换位置,在此之后的元素在下一轮扫描中均不考虑
            }
        }
        
        n = newn;// 更新 n 的 值
        
    }while(newn > 0);
    
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        
        
        int n = 10000;
        int *arr = SortTestHelper::generateRandomArray(n,0,n);
        int *arr2 = SortTestHelper::copyIntArray(arr, n);
        int *arr2x = SortTestHelper::generateNearlyOrderedArray(n, 5);
        int *arr3 = SortTestHelper::copyIntArray(arr, n);
        int *arr4 = SortTestHelper::copyIntArray(arr, n);
        int *arr5 = SortTestHelper::generateNearlyOrderedArray(n, 3);
        int *arr6 = SortTestHelper::copyIntArray(arr, n);

//        SortTestHelper::testSort("选择排序", selectionSort, arr, n);
//        SortTestHelper::testSort("选择排序-优化", selectionSort2, arr2, n);
//        SortTestHelper::testSort("插入排序", insertionSort, arr, n);
        SortTestHelper::testSort("shell 排序", shellSort, arr2, n);
        SortTestHelper::testSort("冒泡排序", BubbleSort2, arr2x, n);

        
//        SortTestHelper::testSort("插入排序", insertionSort2, arr2, n);
//        SortTestHelper::testSort("插入排序(几乎有序数组)", insertionSort2, arr2x, n);
//        SortTestHelper::testSort("冒泡排序", BubbleSort, arr3, n);
//        SortTestHelper::testSort("冒泡排序优化", BubbleSort2, arr4, n);
//        SortTestHelper::testSort("冒泡排序优化(几乎有序数组)", BubbleSort2, arr5, n);
//        SortTestHelper::testSort("希尔排序", shellSort, arr6, n);
        
        delete[] arr;
        delete[] arr2;
        delete[] arr2x;
        delete[] arr3;
        delete[] arr4;
        delete[] arr5;
        delete[] arr6;
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
