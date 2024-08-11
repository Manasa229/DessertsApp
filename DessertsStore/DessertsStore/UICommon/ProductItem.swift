//
//  ProductItem.swift
//  DessertsStore
//
//  Created by Manasa M on 8/6/24.
//

import SwiftUI

struct ProductItem: View {
    var meal: MealModel?

    var body: some View {
  
        // positioning the contents at the start inside the vertical stack
        VStack(alignment: .leading) {
            
            // meal image
            mealImage
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)

           // meal name
            Text(meal?.name ?? "Unknown Dessert")
                .foregroundColor(Color.darkBrownish)
                .lineLimit(2)
                .padding([.top, .bottom], 5)
            
            if let meal = meal {
            
                   // on clicking select, navigating to the next screen to show details
                    NavigationLink(destination:ItemView(mealId: meal.id)) {
                        Text("Select")
                            .foregroundColor(Color.darkBrownish)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.darkerMutedGreen)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 5)
                }
                       }
                           
        
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
    }

    @ViewBuilder
    private var mealImage: some View {
        if let urlString = meal?.thumbnailURL, let url = URL(string: urlString), #available(iOS 15.0, *) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                default:
                    // showing default grey image in ios which does not support
                    placeholderImage
                }
            }
            .frame(height: 150)
        } else {
            // showing default grey image in ios which does not support
            placeholderImage
        }
    }

    private var placeholderImage: some View {
        Color.gray.frame(height: 150)
    }
}


#Preview {
    ProductItem(meal: nil)
}


