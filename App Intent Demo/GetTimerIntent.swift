//
//  GetTimerIntent.swift
//  App Intent Demo
//
//  Created by Jorge Salcedo on 10/11/26.
//

import AppIntents

struct GetTimerIntent: AppIntent {
    static let title: LocalizedStringResource = "Get remaining timer"

    @MainActor
    func perform() async throws -> some IntentResult & ReturnsValue<Int> {
        let remainingSeconds = TimerViewModel.shared.remainingTime

        return .result(value: remainingSeconds)
    }
}
