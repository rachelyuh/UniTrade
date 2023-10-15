//
//  AccountView.swift
//  SwiftUIStarterKitApp
//
//  Created by Osama Naeem on 08/08/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import SwiftUI

struct AccountView: View {
    
    var globalIdentity: String
    
    
    @State var notificationToggle: Bool = false
    @State var locationUsage: Bool = false
    @State var username: String = "f"
    @State var name: String = "j"
    @State var selectedCurrency: Int = 0
    @State public var editProfile = false

    let items = Array(1...12) // Example data
    
    @State
    var viewModel = FirebaseTest();
    
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    HStack {
                        Image("italy")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .background(Color.yellow)
                            .clipShape(Circle())
                            .padding(.bottom, 10)
                            .padding(.leading, 30)
                        VStack {
                            Text(name)
                                .onAppear {
                                    // This function will run when the view appears
                                    updateMyVariable()
                                }
                                .font(.system(size: 30))
                                .padding(.leading, 10)
                                .padding(.top, 10)
                            Text("@\(username)")
                                .onAppear {
                                    // This function will run when the view appears
                                    updateMyVariable()
                                }
                                .padding(.leading, 0)
                                .padding(.bottom, 1)
                            
                            HStack {
                                
                                NavigationLink(destination: EditProfileView()) {
                                    Text("Edit Profile")
                                        .frame(width: 100, height:20)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                    
                                }
                                Button("Share Profile") {
                                    
                                }
                                .frame(width: 100, height:20)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                
                            }
                            
                        }
                        Spacer()
                    }
                
                    HStack {
                        Text("Seller Rating")
                            .padding(.leading, 20)
                            .padding(.top, 10)
                            .font(.system(size: 20))
                            .padding(.bottom, 1)
                        Spacer()
                    }
                    HStack {
                        RatingView()
                            .padding(.leading, 40)
                            .font(.system(size: 20))
                        Spacer()
                    }
                    
                    HStack {
                        Text("Bob's Listings")
                            .padding(.leading, 20)
                            .font(.system(size: 20))
                        Spacer()
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 0.01)
                    HStack {
                        Spacer()
                        Button("Sort List") {
                            
                        }
                        .frame(width: 100, height:20)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        
                        Button("Sort List 2") {
                            
                        }
                        .frame(width: 100, height:20)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                        ForEach(items, id: \.self) { item in
                            Text("\(item)")
                                .frame(width: 110, height: 110)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
                
                
                
            }
         
        }
    }
    func updateMyVariable() {
        viewModel.getUserData(username: globalIdentity) { dictionary in
            if let data = dictionary {
                print("Data retrieved from Firebase:")
                name = data["name"] as! String
                username = data["username"] as! String
            } else {
                print("Failed to retrieve data from Firebase.")
            }
        }
    }
 }



struct StarView: View {
    let isFilled: Bool

    var body: some View {
        Image(systemName: isFilled ? "star.fill" : "star")
            .resizable()
            .frame(width: 30, height: 30)
            .foregroundColor(isFilled ? .yellow : .gray)
    }
}

struct RatingView: View {
    @State private var rating: Int = 0

    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                StarView(isFilled: index <= rating)
                    .onTapGesture {
                        rating = index
                    }
            }
        }
    }
}

struct Previews_AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(globalIdentity: "")
    }
}
