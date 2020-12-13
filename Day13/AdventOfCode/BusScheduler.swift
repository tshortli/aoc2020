//
//  BusScheduler.swift
//  AdventOfCode
//
//  Created by Allan Shortlidge on 12/5/20.
//

import Foundation

public struct BusScheduler {
    let earliestTime: Int
    let busIDsByIndex: [Int: Int]
    
    public init(input: String) {
        let lines = input.components(separatedBy: .newlines)
        self.earliestTime = Int(lines.first!)!
        
        let busIDs = lines.last!.components(separatedBy: ",").map { Int($0) }
        self.busIDsByIndex = busIDs.enumerated().reduce(into: [Int: Int]()) {
            guard let busID = $1.1 else { return }
            $0[$1.0] = busID
        }
    }
    
    public func earliestBusIDTimesDelay() -> Int {
        var minDelay = Int.max
        var minBusID = Int.max
        for busID in busIDsByIndex.values {
            let delay = busID * (earliestTime / busID + 1) - earliestTime
            if delay < minDelay {
                minDelay = delay
                minBusID = busID
            }
        }
        
        return minBusID * minDelay
    }
    
    public func earliestSynchronizedDeparture() -> Int {
        var timestamp = busIDsByIndex[0]!
        
        repeat {
            let matched = matchedBusIDs(for: timestamp)
            if matched.count == busIDsByIndex.count {
                break
            }
            timestamp += matched.reduce(1, *)
        } while true
        
        return timestamp
    }
    
    func matchedBusIDs(for timestamp: Int) -> [Int] {
        var result: [Int] = []
        for (index, busID) in busIDsByIndex where (timestamp + index) % busID == 0 {
            result.append(busID)
        }
        return result
    }
    
}
