//
//  WidgetIntent.swift
//  BmtcMate
//
//  Created by Nik on 6/11/23.
//

import Foundation
import AppIntents


struct WidgetIntent: AppIntent {
    static var title: LocalizedStringResource = "Open in BMTCMate"
    
    func perform() async throws -> some IntentResult {
        return .result();
    }
}
