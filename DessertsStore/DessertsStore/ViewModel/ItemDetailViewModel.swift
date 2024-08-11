//
//  ItemDetailViewModel.swift
//  DessertsStore
//
//  Created by Manasa M on 8/10/24.
//

import SwiftUI


//data model for meal details
class ItemDetailViewModel: ObservableObject {
    static let shared = ItemDetailViewModel()
    
    @Published var mealDetail: MealDetailModel?
    @Published var isLoading: Bool = true

    func serviceCallList(mealId: String) async {
        let urlString = Globs.baseUrl + "lookup.php?i=\(mealId)"
       

        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                print("Invalid url")
            }
            return
        }
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        defer {
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
       

            let decodedResponse = try JSONDecoder().decode([String: [MealDetailModel]].self, from: data)


            if let mealsArray = decodedResponse["meals"] {
                          let filteredMeals = mealsArray.filter { meal in
                              return !(meal.name.isEmpty || meal.instructions.isEmpty)
                          }

             
                          if let mealDict = filteredMeals.first {
                              DispatchQueue.main.async {
                                  self.mealDetail = mealDict
                              }
                          } else {
                              DispatchQueue.main.async {
                                  print("No valid meal details available.")
                              }
                          }
            } else {
                
                print("Error")
            }
        } catch {
            DispatchQueue.main.async {
                print("\(error.localizedDescription)")
            }
        }
    }
}
