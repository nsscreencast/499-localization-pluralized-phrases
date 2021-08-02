//
//  Meal.swift
//  DinnerTime
//
//  Created by Ben Scheirman on 6/4/21.
//

import Foundation

struct Meal: Codable {
    var identifier = UUID()
    var name: String
    var date: Date
    var type: MealType
}

extension Meal: Hashable { }
extension Meal: Equatable { }
extension Meal: Identifiable {
    var id: UUID { identifier }
}
