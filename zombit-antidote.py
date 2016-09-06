


def answer(meetings):

    result = []
    shortestMeetingForEachStart = {}
    
    # meetings day time goes from 0 to 1-000-000
    # let's say our day is not booked yet means any time during the day is false
    day = [False] * 1000000

    for meeting in meetings:
        # make a dictionary where key is the beginning of the section and
        # value is the section itself (which is element of the input list)
        # going through all sections and choose only the smallest one for each beginning
        # so for input like  [[1, 3], [3, 4], [2, 3], [2, 4]]
        # dictionary will be [2: [2, 3], 3: [3, 4], 1: [1, 3]]
        meetingStart = meeting[0]
        
        if meetingStart in shortestMeetingForEachStart:
            meetingStop = meeting[1]
            currentMeeting = shortestMeetingForEachStart[meetingStart]
            if currentMeeting[1] > meetingStop:
                shortestMeetingForEachStart[meetingStart] = meeting
        else:
            shortestMeetingForEachStart[meetingStart] = meeting

    # all meeting (each of them shortest for starting time)
    # sorted from low to high by ending time
    # for ->  [[0, 6], [7, 13], [14, 20], [5, 8], [12, 15]]
    # will be [[0, 6], [5, 8], [7, 13], [12, 15], [14, 20]]
    timeFrames = shortestMeetingForEachStart.values()
    from operator import itemgetter
    timeFrames.sort(key=itemgetter(1), reverse=False)
    
    for frame in timeFrames:
        canAdd = True
        # check if there any overlapping
        for i in range(frame[0], frame[1]):
            if day[i] == True:
                canAdd = False
                break

        # if no overlapping - book the meeting
        if canAdd:
            for i in range(frame[0], frame[1]):
                day[i] = True
            result.append(frame)


    return len(result)



input1 = [[1, 3], [3, 4], [2, 3], [2, 4]]
input2 = [[0, 1], [1, 2], [2, 3], [3, 5], [4, 5]]
input3 = [[0, 1000000], [42, 43], [0, 1000000], [42, 43]]
input4 = [[0, 999999], [999999, 1000000]]
input5 = [[0, 6], [7, 13], [14, 20], [5, 8], [12, 15]]
print(answer(input1))
print(answer(input2))
print(answer(input3))
print(answer(input4))
print(answer(input5))





