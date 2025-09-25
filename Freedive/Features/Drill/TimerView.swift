//
//  TimerView.swift
//  Freedive
//
//  Created by Kanghos on 9/23/25.
//

import SwiftUI

struct TimerView: View {
    enum TimerState: String, Equatable, Identifiable {
        case pause = "Pause"
        case resume = "Resume"
        case stop = "Stop"

        var id: String {
            rawValue
        }
    }

    @State var state: TimerState = .stop
    @State var startTime: Date?
    @State var elapsedTime: TimeInterval = 0
    @State var timerTask: Task<Void, Never>?
    @State var hangDate: Date?
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        VStack {
            Text(elapsedTime, format: .number)
                .monospaced()
                .font(.system(size: 70))
                .contentTransition(.numericText())

            HStack {
                Group {
                    Button  {
                        if state == .resume {
                            state = .pause
                        } else {
                            state = .resume
                        }
                    } label: {
                        Text(state == .resume ? "Pause" : "Resume")
                            .frame(width: 70, height: 50)
                    }

                    if state != .stop {
                        Button {
                            withAnimation {
                                state = .stop
                            }
                        } label: {
                            Text("Stop")
                                .frame(width: 70, height: 50)
                        }
                        .tint(.red)
                    }
                }
            }
            .buttonStyle(.borderedProminent)

        }
        .onChange(of: state, { oldValue, newValue in
            switch state {
            case .pause:
                stopTimer()
            case .resume:
                startTimer()
            case .stop:
                stopTimer()
                elapsedTime = 0
            }
        })
        .onChange(of: scenePhase, { oldValue, newValue in
            handlePhase(newValue)
        })
        .onAppear {

        }
        .onDisappear {
        }
        .navigationTitle("Drill")
    }
}

extension TimerView {
    func startTimer() {
        stopTimer()
        timerTask = Task {
            while state == .resume {
                try? await Task.sleep(for: .seconds(1), clock: .continuous)
                guard !Task.isCancelled else { return }
                withAnimation {
                    elapsedTime += 1
                }
                print("Tick")
            }
        }
    }

    func stopTimer() {
        timerTask?.cancel()
        timerTask = nil
    }

    func handlePhase(_ phase: ScenePhase) {
        switch phase {
        case .background:
            // Only set hangDate if timer is currently running
            if state == .resume {
                hangDate = Date()
                state = .pause
            }
        case .inactive: break
        case .active:
            // Only restart timer if it was running when it went to background
            if let hangDate {
                let current = Date()
                let elapsed = current.timeIntervalSince(hangDate)
                elapsedTime += TimeInterval(Int(elapsed))
                state = .resume
                self.hangDate = nil  // Clear hangDate after processing
            }
        @unknown default:
            precondition(false)
        }
    }
}

#Preview {
    NavigationStack {
        TimerView()
    }
}
