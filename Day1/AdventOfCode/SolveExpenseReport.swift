//
//  HelloWorld.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 11/29/20.
//

import Foundation

public func solveExpenseReport(_ items: [Int], target: Int) -> Int? {
    for first in items {
        for second in items {
            if first == second {
                continue
            }

            for third in items {
                if second == third {
                    continue
                }

                if first + second + third == target {
                    return first * second * third
                }
            }
        }
    }

    return nil
}
