//
//  ItemViewModel.swift
//  DessertsStore
//
//  Created by Manasa M on 8/5/24.
//

import SwiftUI


class ItemViewModel: ObservableObject {
    static let shared = ItemViewModel()
    
    @Published var isLoading: Bool = false
    @Published var mealModels: [MealModel] = []

    func serviceCallList() async {
        let urlString = Globs.baseUrl + "/filter.php?c=Dessert"
        
        DispatchQueue.main.async {
            self.isLoading = true
        }

        defer {
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                print("Invalid url")
            }
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode([String: [MealModel]].self, from: data)
            
            if let meals = decodedResponse["meals"] {
                       
                let filteredMeals = meals.filter { meal in
                    return !meal.name.isEmpty 
                }
                           
                           DispatchQueue.main.async {
                               self.mealModels = filteredMeals.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
                            
                           }
            } else {
                print("Error occured")
               
            }
        } catch {
            DispatchQueue.main.async {
                print("\(error.localizedDescription)")
            }
        }
    }
}
