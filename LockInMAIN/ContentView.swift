//
//  ContentView.swift
//  LockInMAIN
//
//  Created by Scholar on 7/15/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var timeManager = TimeManager()
    
    var title: String {
        switch timeManager.timeToWork {
        case .notStarted:
            return "Let's Get Started!!!"
        case .startedWorking:
            return "You are now working on your task"
        case .finishedWorking:
            return "You have completed your task!"
        }
    }
    
    var body: some View {
        ZStack {
            //MARK: Background
            Color(#colorLiteral(red: 0.772808969, green: 1, blue: 0.9533693194, alpha: 1))
                .opacity(0.5)
                .ignoresSafeArea(.all)
            
            content
        }
    }
    
    var content : some View {
        ZStack {
            VStack(spacing: 10) {
                // MARK: Title
                Text(title)
                    .font(.title)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0, blue: 0.7282488942, alpha: 1)))
                    .padding(.top, 25.0)
                    .opacity(0.5)
                    .fontWeight(.bold)
                
                //MARK: Progress Timer
                Text(timeManager.taskPeriod.rawValue)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(.thinMaterial)
                    .background(Color(#colorLiteral(red: 1, green: 0.9200647473, blue: 0.473361969, alpha: 1)))
                    .cornerRadius(15)
                
                Spacer()
            }
            .padding()
            
            VStack(spacing: 40) {
                // MARK: Progress Ring
                ProgressRing()
                    .environmentObject(timeManager)
                
                HStack(spacing: 60){
                    //MARK: Start Time
                    VStack(spacing: 5){
                        Text(timeManager.timeToWork == .notStarted ? "Start" : "Started")
                            .opacity(0.5)
                        
                        Text(timeManager.startTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                    
                    //MARK: End Time
                    VStack(spacing: 5){
                        Text(timeManager.timeToWork == .notStarted ? "End" : "Ends")
                            .opacity(0.5)
                        
                        Text(timeManager.endTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                }
                
                //MARK: Button
                Button {
                    timeManager.toggleTimer()
                } label: {
                    Text(timeManager.timeToWork == .startedWorking ? "End task" : "Start task")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(.thinMaterial)
                        .background(Color(#colorLiteral(red: 1, green: 0.9200647473, blue: 0.473361969, alpha: 1)))
                        .cornerRadius(15)
                }
            }
            .padding()
        }
        .foregroundColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

