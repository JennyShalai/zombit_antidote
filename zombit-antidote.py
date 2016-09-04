


def answer(meetings):

    result = 0
    shortestMeetingForEachStart = {}
    meetingsTimeFrame = {}
    # meetings day time goes from 0 to 1-000-000
    day = []

    for meeting in meetings:
        # make a dictionary where key is the beginning of the section and
        # value is the section itself (which is element of the input list)
        # going through all sections and choose only the smallest one for each beginning
        # so for input like  [[1, 3], [3, 4], [2, 3], [2, 4]]
        # dictionary will be [2: [2, 3], 3: [3, 4], 1: [1, 3]]
        meetingStart = meeting[0]
        
        if meetingStart in shortestMeetingForEachStart:
            meetingStop = meeting[-1]
            currentMeeting = shortestMeetingForEachStart[meetingStart]
            if currentMeeting[-1] > meetingStop:
                shortestMeetingForEachStart[meetingStart] = meeting
        else:
            shortestMeetingForEachStart[meetingStart] = meeting
    
    for (key, value) in shortestMeetingForEachStart.items():
        # make dictionary where key is "delta-time" that meeting goes and
        # value is meetings themselfs
        # so for input like [2: [2, 3], 3: [3, 4], 1: [1, 3]]
        # output will be -> [2: [[1, 3]], 1: [[2, 3], [3, 4]]]
        deltaTime = value[-1] - value[0]
        if deltaTime in meetingsTimeFrame:
            meetingsTimeFrame[deltaTime].append(value)
        else:
            meetingsTimeFrame[deltaTime] = [value]
    
    # let's say our day is not booked yet means any time during the day is false
    day = [False] * 1000000
    
    # time-frame for meeting from losert to highest
    deltaTimeFrames = sorted(meetingsTimeFrame.keys(), key = int, reverse = False)

    for delta in deltaTimeFrames:
        # try to put meedting in calendar (boolian day) if there is an empty slot
        meetings = meetingsTimeFrame[delta]
        for meeting in meetings:
            canAdd = True
            # check if there any overlaping
            for i in range(meeting[0], meeting[-1]):
                if day[i] == True:
                    canAdd = False
                    break
            
            # if no overlaping - book the meeting
            if canAdd:
                for i in range(meeting[0], meeting[-1]):
                    day[i] = True
                    result += 1





    return result



input1 = [[1, 3], [3, 4], [2, 3], [2, 4]]
input2 = [[0, 1], [1, 2], [2, 3], [3, 5], [4, 5]]
input3 = [[0, 1000000], [42, 43], [0, 1000000], [42, 43]]
print(answer(input1))
print(answer(input2))
print(answer(input3))





