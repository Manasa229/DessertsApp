//
//  ItemView.swift
//  DessertsStore
//
//  Created by Manasa M on 8/4/24.
//

import SwiftUI


struct ItemView: View {
    var mealId: String
    @ObservedObject var itemDetailVM = ItemDetailViewModel.shared

    var body: some View {
        ZStack{
            // applying the background color 
            Color.lightMutedGreen
                .edgesIgnoringSafeArea(.all)
            if itemDetailVM.isLoading {
                VStack {
                    
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                    Spacer()
                }
                .transition(.opacity)
            } else {
                VStack(spacing: 15) {
                    if let mealDetail = itemDetailVM.mealDetail {
                        ProductDetail(mealDeatils: mealDetail)
                    } else {
                        Text("No meal details available")
                            .foregroundColor(.gray)
                    }
                }
                
                
            }
        }
            .onAppear {
                Task{
                    await itemDetailVM.serviceCallList(mealId: mealId)
                }
                
            }
    
    }
}

#Preview {
   ItemView(mealId: "53049")
}


