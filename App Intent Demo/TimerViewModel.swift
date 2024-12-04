//
//  ViewModel.swift
//  appintent
//
//  Created by Jorge Salcedo on 10/11/24.
//

import Foundation

class TimerViewModel: ObservableObject {
    static let shared = TimerViewModel()
    @Published var remainingTime: Int = 0
    private var endDate: Date?

    /// Sets the timer duration based on seconds
    func addTimer(seconds: Int) {
        DispatchQueue.main.async {
            self.endDate = Date().addingTimeInterval(TimeInterval(seconds))
            self.updateRemainingTime()
        }
    }
    
    /// Dynamically calculates the remaining time based on the current date.
    func updateRemainingTime() {
        guard let endDate = endDate else {
            self.remainingTime = 0
            return
        }
        let now = Date()
        let timeLeft = Int(endDate.timeIntervalSince(now))
        self.remainingTime = max(timeLeft, 0) // Avoid negative time
    }
    
    func getTimer() -> Int {
        return self.remainingTime
    }
}
