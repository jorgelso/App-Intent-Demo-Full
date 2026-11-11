//
//  AddTimerIntent.swift
//  App Intent Demo
//
//  Created by Jorge Salcedo on 10/11/24.
//

import AppIntents

struct AddTimerIntent: AppIntent {
    static let title: LocalizedStringResource = "Start a New Timer"

    @Parameter(title: "Duration", description: "How long to block apps for",
               defaultUnit: .minutes, supportsNegativeNumbers: false)
    var duration: Measurement<UnitDuration>

    static var parameterSummary: some ParameterSummary {
        Summary("Block apps for \(\.$duration)")
    }

    @MainActor
    func perform() async throws -> some IntentResult {
        let seconds = Int(duration.converted(to: .seconds).value)

        if seconds > TimerViewModel.shared.remainingTime {
            TimerViewModel.shared.addTimer(seconds: seconds)
        }

        return .result()
    }
}
