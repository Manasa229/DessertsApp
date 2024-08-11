//
//  MenuView.swift
//  DessertsStore
//
//  Created by Manasa M on 8/4/24.
//

import SwiftUI


struct MenuView: View {
    @ObservedObject var itemVM = ItemViewModel.shared
 
    var body: some View {
        NavigationView {
            ZStack {
                Color.lightMutedGreen
                    .edgesIgnoringSafeArea(.all)
                
                // spinner will be shown until we get response from API or some error
                if itemVM.isLoading {
                    VStack {
                        Spacer()
                        ProgressView("")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                        Spacer()
                    }
                } else {
                    ScrollViewReader { proxy in
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVStack(spacing: 15) {
                             
                                Color.clear
                                    .frame(height: 1)
                                    .id("TOP")
                                
                                ForEach(itemVM.mealModels) { meal in
                                    ProductItem(meal: meal)
                                        .transition(.scale)
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                        }
                        
                            // added a button to go to the top of the screen
                            Button(action: {
                                withAnimation {
                                    proxy.scrollTo("TOP", anchor: .top)
                                }
                            }) {
                                Image(systemName: "arrow.up")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.darkBrownish)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                            }
                            .padding()
                        
                    }
                }
            }
            .navigationTitle("Menu")
    
            .onAppear {
      
                Task {
                                await itemVM.serviceCallList()
                            }
            }
            .animation(.easeInOut, value: itemVM.isLoading)
            .animation(.easeInOut, value: itemVM.mealModels)
        }
    }
}






#Preview {
    NavigationView{
        MenuView()
        ItemView(mealId: "53049")
    }
   
}
