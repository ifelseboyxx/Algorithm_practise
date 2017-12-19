//
//  SortTestHelper.h
//  Algorithm
//
//  Created by Jason on 2017/12/18.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#ifndef SortTestHelper_h
#define SortTestHelper_h

#include <iostream>
#include <ctime>

using namespace std;

namespace SortTestHelper {
    
    /*
     // 随机 int 类型的无序数组
     //使用方式
     int n = 10000;
     int *arr = SortTestHelper::generateRandomArray(n,0,n);
     **/
    int* generateRandomArray(int n, int rangeL, int rangeR){
        
        assert(rangeL <= rangeR);
        
        int *arr = new int[n];
        srand(time(NULL));
        for (int i = 0; i < n; i++) {
            arr[i] = rand() % (rangeR - rangeL + 1) + rangeL;
        }
        return arr;
    }
    
    // 打印数组
    void printArr(int arr[], int n) {
        for (int i = 0; i < n ; i++) {
            cout << arr[i] << " ";
        }
        cout << endl;
        return;
    }
    
    // 监测是否是排序成功的
    bool isSorted(int arr[], int n) {
        for (int i = 0; i < n - 1; i++) {
            if (arr[i] > arr[i + 1]) {
                return false;
            }
        }
        return true;
    }
    
    // 测试性能消耗时间
    void testSort(string sortName, void(*sort)(int[],int),int arr[], int n) {
        clock_t startTime = clock();// 执行前的时间
        sort(arr,n);
        clock_t endTime = clock(); // 执行完后的时间
        
        // 判断下是否是有序的
        assert(isSorted(arr, n));
        
        // double(endTime - startTime) / CLOCKS_PER_SEC 这里返回的是秒
        cout << sortName << " : " << double(endTime - startTime) / CLOCKS_PER_SEC << "秒" << endl;
        
        return;
    }
    
    // 拷贝数组
    int* copyIntArray(int a[], int n) {
        int* arr = new int[n];
        copy(a, a+n,arr);
        return arr;
    }
    
}




#endif /* SortTestHelper_h */
