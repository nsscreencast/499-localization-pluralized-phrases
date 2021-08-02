//
//  MealType.swift
//  DinnerTime
//
//  Created by Ben Scheirman on 6/4/21.
//

import Foundation

enum MealType: String, Codable, CaseIterable {
    case breakfast
    case lunch
    case dinner
    case dessert
    case snack
    
    var localized: String {
        switch self {
        case .breakfast: return .localized.breakfast
        case .lunch: return .localized.lunch
        case .dinner: return .localized.dinner
        case .dessert: return .localized.dessert
        case .snack: return .localized.snack
        }
    }
}
