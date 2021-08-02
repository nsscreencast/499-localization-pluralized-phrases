//
//  PlanDay.swift
//  DinnerTime
//
//  Created by Ben Scheirman on 6/4/21.
//

import Foundation

class PlanDay {
    let date: Date
    var meals: [Meal]
    
    init(date: Date, meals: [Meal] = []) {
        self.date = date
        self.meals = meals
    }
}
