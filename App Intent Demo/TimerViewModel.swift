//
//  TimerViewModel.swift
//  App Intent Demo
//
//  Created by Jorge Salcedo on 10/11/26.
//

import Foundation
import Observation

@MainActor
@Observable
final class TimerViewModel {
    static let shared = TimerViewModel()

    private static let endDateKey = "endDate"

    private(set) var endDate: Date? {
        didSet { UserDefaults.standard.set(endDate, forKey: Self.endDateKey) }
    }

    private init() {
        endDate = UserDefaults.standard.object(forKey: Self.endDateKey) as? Date
    }

    var remainingTime: Int {
        guard let endDate else { return 0 }
        return max(Int(endDate.timeIntervalSinceNow.rounded(.up)), 0)
    }

    func addTimer(seconds: Int) {
        endDate = .now.addingTimeInterval(TimeInterval(seconds))
    }
}
