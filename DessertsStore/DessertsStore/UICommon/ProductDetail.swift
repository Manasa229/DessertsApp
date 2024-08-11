//
//  ProductDetail.swift
//  DessertsStore
//
//  Created by Manasa M on 8/9/24.
//

import SwiftUI

struct ProductDetail: View {
    var mealDetails: MealDetailModel?
 
    
    var body: some View {
        ScrollView {
            
            if let meal = mealDetails {
                VStack(alignment: .leading, spacing: 15) {
                    
                    if let youtubeLink = meal.youtubeLink, let url = URL(string: youtubeLink) {
                        
                        // web view to show the youtube video in the application
                        WebView(url: url)
                            .frame(height: 160)
                            .cornerRadius(10)
                            .padding(.top, 10)
                    }
                    
                    
                    Text(meal.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.darkBrownish)
                    
                    Text("Category: \(String(describing: meal.category))")
                        .font(.subheadline)
                        .foregroundColor(Color.darkBrownish)
                    
                    Text("Area: \(String(describing: meal.area))")
                        .font(.subheadline)
                        .foregroundColor(Color.darkBrownish)
                    
                    Text("Ingredients")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.darkBrownish)
                    
                    ForEach(0..<meal.ingredients.count, id: \.self) { index in
                        Text("• \(meal.ingredients[index]) - \(meal.measures[index])")
                            .foregroundColor(Color.darkBrownish)
                        
                    }
                    Text("Instructions")
                        .fontWeight(.semibold)
                        .padding(.top)
                        .foregroundColor(Color.darkBrownish)
                    
                    Text(meal.instructions)
                        .padding(.bottom)
                        .foregroundColor(Color.darkBrownish)
                    
                    
                }.padding(10)
                
                
                    .toolbar {
                                ToolbarItem(placement: .principal) {
                                    Text("Meal Details")
                                        .font(.headline)
                                        .foregroundColor(Color.darkBrownish)
                                }
                            }
                            .navigationBarTitleDisplayMode(.inline)
      
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    ProductDetail(mealDetails: nil)
}
