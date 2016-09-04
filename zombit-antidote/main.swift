//
//  main.swift
//  zombit-antidote
//
//  Created by Flatiron School on 9/4/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

func answer(input: [[Int]]) -> Int {
    
    var shortestMeetingForEachStart: [Int: [Int]] = [:]
    var meetingsTimeFrame: [Int: [Array<Int>]] = [:]
    
    
    for meeting in input {
        // make a dictionary where key is the beginning of the section and
        // value is the section itself (which is element of the input list)
        // going through all sections and choose only the smallest one for each beginning
        // so for input like  [[1, 3], [3, 4], [2, 3], [2, 4]]
        // dictionary will be [2: [2, 3], 3: [3, 4], 1: [1, 3]]
        if let meetingStart = meeting.first {
            if shortestMeetingForEachStart[meetingStart] == nil {
                shortestMeetingForEachStart[meetingStart] = meeting
            } else {
                if let meetingStop = meeting.last {
                    if shortestMeetingForEachStart[meetingStart]!.last! > meetingStop {
                        shortestMeetingForEachStart[meetingStart] = meeting
                    }
                }
            }
        }
    }
    print(shortestMeetingForEachStart)
    
    
    for (_, value) in shortestMeetingForEachStart {
        // make dictionary where key is "delta-time" that meeting goes and
        // value is meetings themselfs
        // so for input like [2: [2, 3], 3: [3, 4], 1: [1, 3]]
        // output will be -> [2: [[1, 3]], 1: [[2, 3], [3, 4]]]
        let deltaTime = value.last! - value.first!
        if meetingsTimeFrame[deltaTime] == nil {
            meetingsTimeFrame[deltaTime] = [value]
        } else {
            meetingsTimeFrame[deltaTime]?.append(value)
        }
    }
    print(meetingsTimeFrame)
    
    
    return 0
}

let input1 = [[1, 3], [3, 4], [2, 3], [2, 4]]

print(answer(input1))

