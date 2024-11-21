//
//  Untitled.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 17.11.2024.
//

import Foundation

struct TimeInterval {
    var hours: Int
    var minutes: Int
    var seconds: Int
    
    // Метод для преобразования в общее количество секунд
    func toTotalSeconds() -> Double {
        return (Double(hours) * 3600.0) + (Double(minutes) * 60.0) + Double(seconds)
    }
    
    // Инициализация из общего количества секунд
    init(totalSeconds: Double) {
        self.hours = Int(totalSeconds) / 3600
        self.minutes = (Int(totalSeconds) % 3600) / 60
        self.seconds = Int(totalSeconds) % 60
    }
}

enum TimeComponent: Int {
    case hours = 0
    case minutes
    case seconds
}
