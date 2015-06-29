//
//  SudokuKiller.swift
//  Sudoku
//
//  Created by wayne on 15/6/26.
//  Copyright © 2015年 wayne. All rights reserved.
//

import Foundation

class SudokuKiller {
    var tu: [[Int]] = [[0, 0, 0, 0, 0, 0, 0, 0, 0],
                       [0, 0, 0, 0, 0, 0, 0, 0, 0],
                       [0, 0, 0, 0, 0, 0, 0, 0, 0],
                       [0, 0, 0, 0, 0, 0, 0, 0, 0],
                       [0, 0, 0, 0, 0, 0, 0, 0, 0],
                       [0, 0, 0, 0, 0, 0, 0, 0, 0],
                       [0, 0, 0, 0, 0, 0, 0, 0, 0],
                       [0, 0, 0, 0, 0, 0, 0, 0, 0],
                       [0, 0, 0, 0, 0, 0, 0, 0, 0],
                       [0, 0, 0, 0, 0, 0, 0, 0, 0]]
    // 或者
    // var tu = [[Int]](count: 9, repeatedValue: [Int](count: 9, repeatedValue: 0))
    
    private var callback: ((data: [[Int]], finish: Bool) -> Void)?
    
    // 指定一个元素，判断该元素是否符合游戏规则
    private func isValid(i: Int, _ j: Int) -> Bool {
        let element = tu[i][j]
        
        // 检查该元素所在行和列
        for tmp in 0..<9 {
            if (tmp != i && tu[tmp][j] == element) || (tmp != j && tu[i][tmp] == element) {
                return false
            }
        }
        
        // 检查该元素所在九宫格
        let query = [0, 0, 0, 3, 3, 3, 6, 6, 6]
        for var m = query[i]; m < query[i] + 3; ++m {
            for var n = query[j]; n < query[j] + 3; ++n {
                if (m != i || n != j) && tu[m][n] == element {
                    return false
                }
            }
        }
        
        return true
    }
    
    // 使用回溯算法进行深度优先搜索
    private func writeNumberToGrid(grid: Int) {
//        print("\(grid)\t", appendNewline: false)
        // 如果最后一个格子都填完了，就退出搜索
        if grid == 81 {
            // 得到一个解
            callback!(data: tu, finish: false)
            return
        }
        
        // 获取行和列
        let i = grid / 9
        let j = grid % 9
        
        // 如果当前格子不需要填数字（已经有数字存在）就跳到下一个格子
        if tu[i][j] != 0 {
            writeNumberToGrid(grid + 1)
            return
        }
        
        // 尝试 1 - 9 的各种解
        for num in 1...9 {
            tu[i][j] = num
            if isValid(i, j) {
                // 验证通过，继续下一个格子
                writeNumberToGrid(grid + 1)
            }
        }
        
        // 这个时候，如果程序突破了上面各种 if 的重重阻拦运行到这里
        // 只能说明，擦，这条路走不通，无解。回溯吧。
        tu[i][j] = 0
    }
    
    func kill(done: (data: [[Int]], finish: Bool) -> Void) {
        callback = done
        writeNumberToGrid(0)
        callback!(data: [], finish: true)
    }
}
















