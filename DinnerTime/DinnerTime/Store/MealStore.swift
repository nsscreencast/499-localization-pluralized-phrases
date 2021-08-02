//
//  MealStore.swift
//  DinnerTime
//
//  Created by Ben Scheirman on 6/4/21.
//

import Foundation

extension Notification.Name {
    static let mealsChanged = NSNotification.Name("mealsChanged")
}

class MealStore {
    private(set) var meals: [Meal] {
        didSet {
            mealsChanged()
        }
    }
    
    private let storage: Storage<[Meal]>
    
    init(storage: Storage<[Meal]>) {
        self.storage = storage
        meals = []
    }
    
    func meals(on date: Date) -> [Meal] {
        let components = Calendar.current.dateComponents([.day, .month, .year], from: date)
        return meals.filter { meal in
            let mealComponents = Calendar.current.dateComponents([.day, .month, .year], from: meal.date)
            return mealComponents == components
        }
    }
    
    func update(_ meal: Meal) {
        guard let existingIndex = meals.firstIndex(where: { $0.identifier == meal.identifier }) else {
             fatalError("This meal doesn't exist in the store. Call add instead.")
        }
        meals[existingIndex] = meal
    }
    
    func add(_ meal: Meal) {
        guard !meals.contains(where: { $0.identifier == meal.identifier }) else {
            fatalError("This meal already exists in the store")
        }
        meals.append(meal)
    }
    
    func remove(_ meal: Meal) {
        meals.removeAll(where: { $0.identifier == meal.identifier })
    }
    
    private func mealsChanged() {
        do {
            print("Saving meals")
            try save()
        } catch {
            print("Error saving meals: \(error)")
        }
        NotificationCenter.default.post(name: .mealsChanged, object: self)
    }

    func load() throws {
        meals = try storage.load() ?? []
    }
    
    func save() throws {
        try storage.save(meals)
    }
    
    func clear() throws {
        try storage.removeAllData()
    }
}
