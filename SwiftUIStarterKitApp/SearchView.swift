///
//  ShopContentView.swift
//  SwiftUIStarterKitApp
//
//  Created by Osama Naeem on 06/08/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import SwiftUI
import Combine

class Search: ObservableObject {
    var listings : [ListingInformation]
    
    init(data: [ListingData]) {
        self.listings = ((data[1].activitiesPlaces) + (data[2].activitiesPlaces))
    }

}

struct SearchView: View {
    @EnvironmentObject var settings: UserSettings
    @ObservedObject var search : Search
    @State var isShowing: Bool = false
    @State var placeItemSelected: ListingInformation? = nil
    @State var searchText: String = ""
    
    var filteredListings: [ListingInformation] {
        guard !searchText.isEmpty else { return search.listings }
        return search.listings.filter { listing in
            listing.listingName.lowercased().contains(searchText.lowercased())
        }
    }

    private let twoColumnGrid = [
        GridItem(.flexible(minimum: 150), spacing: 10),
        GridItem(.flexible(minimum: 150), spacing: 10),
    ]
    
    var body: some View {
        NavigationStack {
                VStack {
                    Text("Search").font(.system(size: 30, weight: .bold, design: .default)).padding(.top, 10)
                    TextField("What are you looking for today?", text: $searchText)
                        .padding(.horizontal, 40)
                        .frame(width: UIScreen.main.bounds.width - 50, height: 40, alignment: .leading)
                        .background(Color(#colorLiteral(red: 0.9294475317, green: 0.9239223003, blue: 0.9336946607, alpha: 1)))
                        .clipped()
                        .cornerRadius(10)
                        .overlay(
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 16)
                        ).padding(.bottom, 5)
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: twoColumnGrid, spacing: 10) {
                            ForEach(filteredListings) { item in
                                Button(action: {
                                    self.placeItemSelected = item
                                    self.isShowing = true
                                }) {
                                    MarketBestSellerViews(listingInfo: item)
                                        .frame(width: 150, height: 200)
                                }.padding(.bottom, 10)
                            }
                        }.padding(.leading, 20)
                            .padding(.trailing, 20)
                            .padding(.bottom, 10)
                            .padding(.top, 30)
                    }
                }
        }.sheet(isPresented: self.$isShowing) { ListingDetailView(isShowing: self.$isShowing, placeItem: self.$placeItemSelected)}
    }
}
