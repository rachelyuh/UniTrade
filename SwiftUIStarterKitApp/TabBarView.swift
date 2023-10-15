//
//  TabBarView.swift
//  SwiftUIStarterKitApp
//
//  Created by Osama Naeem on 02/08/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import SwiftUI



struct TabbarView: View {
    var listingMarket: ListingMarket = ListingMarket()
    

    var body: some View {
        
        TabView {
            NavigationView {
                ListingView(activtiesData: Listings(data: listingMarket.activityData, items: ListingMarket.listings))
            }
            .tag(0)
            .tabItem {
                Image(systemName: "house.fill")
                    .font(.system(size: 40))
                    .padding(.top, 8)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                Text("Home")
            }
            .onAppear() {
                    listingMarket.setListingInformation()

        
                
                
            }
            
            NavigationView {
                ListingView(activtiesData: Listings(data: listingMarket.activityData, items: ListingMarket.listings))
            }
            .tag(1)
            .tabItem {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 40))
                    .padding(.top, 8)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                Text("Search")
            }
            
            NavigationView {
                CreateListing()
            }
            .tag(2)
            .tabItem {
                Image(systemName: "plus.circle")
                    .font(.system(size: 40))
                    .padding(.top, 8)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                Text("Add Post")
            }
            
            NavigationView {
                ListingView(activtiesData: Listings(data: listingMarket.activityData, items: ListingMarket.listings))
            }
            .tag(3)
            .tabItem {
                Image(systemName: "message.fill")
                    .font(.system(size: 40))
                    .padding(.top, 8)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                Text("Chat")
            }
            
            NavigationView {
                     AccountView()
                  }
                   .tag(4)
                    .tabItem {
                    Image(systemName: "person.fill")
                            .font(.system(size: 40))
                            .padding(.top, 8)
                            .padding(.leading, 5)
                            .padding(.trailing, 5)
                    Text("Profile")
                }
        }
    }
}




struct Previews_TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
