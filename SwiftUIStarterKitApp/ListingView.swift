///
//  ShopContentView.swift
//  SwiftUIStarterKitApp
//
//  Created by Osama Naeem on 06/08/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import SwiftUI
import Combine

struct ListingType {
    var id: Int
    var activityName: String
    var activityNameLabel: String
    var activityImage: String
    var selectedActivity: Bool
}

struct ListingInformation {
    var id: Int
    var listingName: String
    var listingDesc: String
    var seller: String
    var price: Float
    var image: String
   
}

struct ListingData {
    var id: Int
    var activitiesPlaces: [ListingInformation]
}

class Listings: ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    var activitiesCollection : [ListingData] {
       willSet {
            objectWillChange.send()
        }
    }
    
    var activities: [ListingType] {
        willSet {
                   objectWillChange.send()
               }
    }
    
    init(data: [ListingData], items: [ListingType] ) {
        self.activitiesCollection = data
        self.activities = items
    }
}

class ListingSelected: ObservableObject {
    @Published var index: Int = 0
}

struct ListingView: View {
    @EnvironmentObject var settings: UserSettings
    @ObservedObject var activtiesData : Listings
    @ObservedObject var selectedActivity = ActivitySelected()
    @State var isShowing: Bool = false
    @State var placeItemSelected: ListingInformation? = nil
    
    private let twoColumnGrid = [
        GridItem(.flexible(minimum: 150), spacing: 10),
        GridItem(.flexible(minimum: 150), spacing: 10),
    ]

    
    var body: some View {
        GeometryReader { g in
            ScrollView{
                    VStack(alignment: .leading) {
                            HStack (spacing: 10){
                                ForEach(self.activtiesData.activities, id: \.id) { item in
                                    MarketPromotionBannerView(activtiesItems: item, selectedActivity: self.selectedActivity)
                                            .frame(width: 107, height: 60)
                                }
                            }.padding(.leading, 30)
                            .padding(.trailing, 30)
                            .padding(.bottom, 10)
                        
                        Text("\(self.activtiesData.activities[self.selectedActivity.index].activityNameLabel) Listings")
                            .font(.system(size: 20))
                            .padding(.leading, 30)
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                                    LazyVGrid(columns: twoColumnGrid, spacing: 10) {
                                        if(self.selectedActivity.index == 0){
                                            //prob fix the way this is diplayed bc currently just products then services
                                            ForEach(self.activtiesData.activitiesCollection[1].activitiesPlaces, id: \.id) { item in
                                                Button(action: {
                                                    self.placeItemSelected = item
                                                    self.isShowing = true
                                                }) {
                                                        MarketBestSellerViews(listingInfo: item)
                                                            .frame(width: 150, height: 200).padding(.bottom, 0)
                                                }.padding(.bottom, 10)
                                            }
                                            ForEach(self.activtiesData.activitiesCollection[2].activitiesPlaces, id: \.id) { item in
                                                Button(action: {
                                                    self.placeItemSelected = item
                                                    self.isShowing = true
                                                }) {
                                                    MarketBestSellerViews(listingInfo: item)
                                                                        .frame(width: 150, height: 200)
                                                }.padding(.bottom, 10)
                                            }
                                        } else {
                                            ForEach(self.activtiesData.activitiesCollection[self.selectedActivity.index].activitiesPlaces, id: \.id) { item in
                                                Button(action: {
                                                    self.placeItemSelected = item
                                                    self.isShowing = true
                                                }) {
                                                    MarketBestSellerViews(listingInfo: item)
                                                        .frame(width: 150, height: 200)
                                                }.padding(.bottom, 10)
                                            }
                                        }
                                }.padding(.leading, 30)
                                 .padding(.trailing, 30)
                                 .padding(.bottom, 10)
                                 .padding(.top, 10)
                                
                        }
                        
                    }
                    .navigationBarTitle("Listings")
                    .navigationBarItems(trailing:
                    Button(action: {
                        self.settings.loggedIn = false
                    }) {
                        Text("Log Out")
                    })
            }.sheet(isPresented: self.$isShowing) { ListingDetailView(isShowing: self.$isShowing, placeItem: self.$placeItemSelected)}
        }
    }
}

struct MarketBestSellerViews: View {
    
    var listingInfo: ListingInformation
    
    var body: some View {
            VStack{
                Image("\(listingInfo.image)").renderingMode(.original)
                        .resizable()
                        .frame(width: 155, height: 180)
                        .background(Color.black)
                        .cornerRadius(10)
                        .aspectRatio(contentMode: .fill)
                HStack{
                    Text(listingInfo.listingName)
                        .font(.system(size: 15, weight: .bold, design: Font.Design.default))
                        .padding(.top, 5)
                        .padding(.bottom, 24)
                        .foregroundStyle(.black)
                    Text("$ \(listingInfo.price, specifier: "%.2f")")
                        .font(.system(size: 15, weight: .bold, design: Font.Design.default))
                        .padding(.top, 5)
                        .padding(.bottom, 24)
                        .foregroundStyle(.black)
                }

            }
        
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.white)
          
    }
}

struct MarketPromotionBannerView: View {
    var activtiesItems: ListingType
    @ObservedObject var selectedActivity: ActivitySelected
    
    var body: some View {
        
        Button(action: {
            self.selectedActivity.index = self.activtiesItems.id
            
        }) {
            GeometryReader { g in
                   ZStack{
                    Image("\(self.activtiesItems.activityImage)").renderingMode(.original)
                       .resizable()
                       .opacity(0.8)
                       .aspectRatio(contentMode: .fill)
                       .background(Color.black)
                    
                    
                    if (self.selectedActivity.index == self.activtiesItems.id) {
                           Text("✓ \(self.activtiesItems.activityName)")
                                    .font(.system(size: 14, weight: .bold, design: Font.Design.default))
                                    .foregroundColor(Color.white)
                    } else {
                             Text(self.activtiesItems.activityName)
                                    .font(.system(size: 14, weight: .bold, design: Font.Design.default))
                                     .foregroundColor(Color.white)
                    }
                               
                   }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                   .cornerRadius(15)
               }
        }
    }
}
