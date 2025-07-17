//
//  TimeManager.swift
//  LockInMAIN
//
//  Created by Scholar on 7/16/25.
//

import Foundation

enum TimeToWork {
    case notStarted
    case startedWorking
    case finishedWorking
}

enum TaskPlan: String {
    case simple = "Simple"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
    
    var taskPeriod: Double {
        switch self {
        case .simple:
            return 1 * 5 * 5
        case .intermediate:
            return 16 * 60 * 60
        case .advanced:
            return 20 * 60 * 60
        }
    }
}

class TimeManager: ObservableObject {
    @Published private(set) var timeToWork: TimeToWork = .notStarted
    @Published private(set) var taskPeriod: TaskPlan = .simple
    @Published private(set) var startTime: Date
    @Published private(set) var endTime: Date
    @Published private(set) var elapsed: Bool = false
    @Published private(set) var elapsedTime: Double = 0.0
    @Published private(set) var progress: Double = 0.0


    var startingWorkingTime: Double {
        return taskPeriod.taskPeriod
    }

    var finishingWorkingTime: Double {
        return (24*60) - taskPeriod.taskPeriod
    }

    init() {
        let calendar = Calendar.current
        let components = DateComponents(hour: 20)
        let scheduledTime = calendar.nextDate(after: .now, matching: components, matchingPolicy: .nextTime)!
        
        startTime = scheduledTime
        endTime = scheduledTime.addingTimeInterval(TaskPlan.simple.taskPeriod)
    }

    func toggleTimer() {
        timeToWork = timeToWork == .startedWorking ? .finishedWorking : .startedWorking
        startTime = Date()
        endTime = startTime.addingTimeInterval(timeToWork == .startedWorking ? startingWorkingTime : finishingWorkingTime)
        elapsedTime = 0.0
    }

    func track() {
        guard timeToWork == .startedWorking else { return }
        
        print("now", Date().formatted(.dateTime.month().day().hour().minute().second()))
        
        if endTime >= Date() {
            print("Not elapsed")
            elapsed = false
        } else {
            print("Elapsed")
            elapsed = true
        }
        elapsedTime += 1
        print("elaspedTime", elapsedTime)
        
        let totalTime = timeToWork == .startedWorking ? startingWorkingTime : finishingWorkingTime
        progress = (elapsedTime / totalTime * 100).rounded() / 100
        print("progress", progress)
    }
}




