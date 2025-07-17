//
//  Progress Ring.swift
//  LockInMAIN
//
//  Created by Scholar on 7/15/25.
//
import SwiftUI

struct ProgressRing: View {
    @EnvironmentObject var timeManager: TimeManager

    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 30)
                .foregroundColor(Color(hue: 0.737, saturation: 0.335, brightness: 0.98))
                .opacity(0.6)

            Circle()
                .trim(from: 0.0, to: min(timeManager.progress, 1.0))
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [
                            Color(#colorLiteral(red: 0, green: 0.9788618684, blue: 1, alpha: 1)),
                            Color(#colorLiteral(red: 1, green: 0.2376048267, blue: 0.6166681051, alpha: 1)),
                            Color(#colorLiteral(red: 0.7034520507, green: 0.2975217998, blue: 1, alpha: 1)),
                            Color(#colorLiteral(red: 1, green: 0.7966935039, blue: 0, alpha: 1)),
                            Color(#colorLiteral(red: 1, green: 0.6555228829, blue: 0, alpha: 1))
                        ]),
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 30.0, lineCap: .round, lineJoin: .round)
                )
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 1.0), value: timeManager.progress)

            VStack(spacing: 30) {
                if timeManager.timeToWork == .notStarted {
                    // MARK: Upcoming Task
                    VStack(spacing: 5) {
                        Text("Upcoming Task")
                            .opacity(0.6)

                        Text(timeManager.startTime, style: .timer)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                } else {
                    // MARK: Elapsed Time
                    VStack(spacing: 5) {
                        Text("Elapsed Time (\(timeManager.progress.formatted(.percent)))")
                            .opacity(0.6)

                        Text(timeManager.startTime, style: .timer)
                            .font(.title)
                            .fontWeight(.bold)
                    }

                    // MARK: Remaining or Extra Time
                    VStack(spacing: 5) {
                        if !timeManager.elapsed {
                            Text("Remaining Time (\(((1 - timeManager.progress)).formatted(.percent)))")
                                .opacity(0.6)
                        } else {
                            Text("Extra Time")
                                .opacity(0.6)
                        }

                        Text(timeManager.endTime, style: .timer)
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                }
            }
        }
        .frame(width: 250, height: 250)
        .padding()
        .onReceive(timer) { _ in
            timeManager.track()
        }
    }
}

#Preview {
    ProgressRing()
        .environmentObject(TimeManager())
}
