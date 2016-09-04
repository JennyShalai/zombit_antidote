//
//  main.swift
//  zombit-antidote
//
//  Created by Flatiron School on 9/4/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

func answer(input: [[Int]]) -> Int {
    
    var result: Int = 0
    var shortestMeetingForEachStart: [Int: [Int]] = [:]
    var meetingsTimeFrame: [Int: [Array<Int>]] = [:]
    // meetings day time goes from 0 to 1-000-000
    var day: [Bool] = []
    
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
    
    // let's say our day is not booked yet means any time during the day is false
    for _ in 0...1000000 {
        day.append(false)
    }
    
    // time-frame for meeting from losert to highest
    let deltaTimeFrames = Array(meetingsTimeFrame.keys).sort { $0 < $1 }
    
    for delta in deltaTimeFrames {
        // try to put meedting in calendar (boolian day) if there is an epty slot
        if let meetings = meetingsTimeFrame[delta]{
            
            for meeting in meetings {
                var canAdd = true
                for i in meeting.first!..<meeting.last! {
                    // check if there any overlaping
                    if day[i] == true {
                        canAdd = false
                        break
                    }
                }
                // if no overlaping - book the meeting
                if canAdd {
                    for i in meeting.first!..<meeting.last! {
                        day[i] = true
                        result += 1
                    }
                }
            }
            
        }
    }
    
    return result
}

let input1 = [[1, 3], [3, 4], [2, 3], [2, 4]]
let input2 = [[0, 1], [1, 2], [2, 3], [3, 5], [4, 5]]
let input3 = [[0, 1000000], [42, 43], [0, 1000000], [42, 43]]

print(answer(input1))
print(answer(input2))
print(answer(input3))
