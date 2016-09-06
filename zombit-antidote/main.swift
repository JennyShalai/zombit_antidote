//
//  main.swift
//  zombit-antidote
//
//  Created by Flatiron School on 9/4/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

func answer(meetings: [[Int]]) -> Int {
    
    var result: Int = 0
    var shortestMeetingForEachStart: [Int: [Int]] = [:]
    // meetings day time goes from 0 to 1-000-000
    var day: [Bool] = []
    
    for meeting in meetings {
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
    
    
    // let's say our day is not booked yet means any time during the day is false
    for _ in 0...1000000 {
        day.append(false)
    }
    
    // all meeting (each of them shortest for starting time)
    // sorted from low to high by ending time
    // for ->  [[0, 6], [7, 13], [14, 20], [5, 8], [12, 15]]
    // will be [[0, 6], [5, 8], [7, 13], [12, 15], [14, 20]]
    let timeFrames = Array(shortestMeetingForEachStart.values).sort( { $0[1] < $1[1] } )
    print(timeFrames)
    
    // using earliest-finish-time-first algorithm
    for frame in timeFrames {
        var canAdd = true
        for i in frame.first!..<frame.last! {
            // check if there any overlaping
            if day[i] == true {
                canAdd = false
                break
            }
        }
        // if no overlaping - book the meeting
        if canAdd {
            for i in frame.first!..<frame.last! {
                day[i] = true
            }
            result += 1
        }
    }

    return result
}

let input1 = [[1, 3], [3, 4], [2, 3], [2, 4]]
let input2 = [[0, 1], [1, 2], [2, 3], [3, 5], [4, 5]]
let input3 = [[0, 1000000], [42, 43], [0, 1000000], [42, 43]]
let input4 = [[0, 6], [7, 13], [14, 20], [5, 8], [12, 15]]

print(answer(input1))
print(answer(input2))
print(answer(input3))
print(answer(input4))





