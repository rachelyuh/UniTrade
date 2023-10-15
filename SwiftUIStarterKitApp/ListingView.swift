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
    var id: String
    var listingName: String
    var listingDesc: String
    var seller: String
    var price: Float
    var image: Data
   
}

//struct ListingResource {
//    var id: Int
//    var resourceName: String
//    var resourceDescription: String
//    var resources : [ActivityResourcesItem]
//}
//
//struct ListingResourcesItem {
//    var id: Int
//    var resourceName: String
//    var resourceImage: String
//    var resourceDescription: String
//}

struct ListingData {
    var id: Int
    var activitiesPlaces: [ListingInformation]
}

struct ListingFamousPoints {
    var id: Int
    var pointName: String
    var pointImage: String
    var pointDescription: String
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
                        
                        ScrollView(.vertical, showsIndicators: false) {
                                    LazyVGrid(columns: twoColumnGrid, spacing: 10) {
                                        if(self.selectedActivity.index == 0){
                                            //prob fix the way this is diplayed bc currently just products then services
                                            ForEach(self.activtiesData.activitiesCollection[1].activitiesPlaces, id: \.id) { item in
                                                Button(action: {
                                                    self.placeItemSelected = item
                                                    self.isShowing = true
                                                }) {
                                                    VStack{
                                                        MarketBestSellerViews(listingInfo: item)
                                                            .frame(width: 150, height: 200).padding(.bottom, 0)
                                                        Text(item.listingName).font(.system(size: 20))
                                                    }
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
                                
                        }
                        
//                        VStack (spacing: 20) {
//                            ForEach(self.activtiesData.activitiesCollection[self.selectedActivity.index].activityResources, id: \.id) { item in
//                                ShopNewProductViews(activityResources: item)
//                                         .frame(width: g.size.width - 60, height: g.size.width - 60)
//                            }
//                        }.padding(.leading, 30)
                        
                        
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
//                Image(uiImage: (UIImage(data: listingInfo.image) ?? UIImage(data: Data()))!).renderingMode(.original)
//                        .resizable()
//                        .frame(width: 155, height: 200)
//                        .background(Color.black)
//                        .cornerRadius(10)
//                        .opacity(0.8)
//                        .aspectRatio(contentMode: .fill)
                    Spacer()
                    Text(listingInfo.listingName)
                        .foregroundColor(Color.white)
                        .font(.system(size: 20, weight: .bold, design: Font.Design.default))
                        .padding(.bottom, 24)
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
//                    Image("\(self.activtiesItems.activityImage)").renderingMode(.original)
//                       .resizable()
//                       .opacity(0.8)
//                       .aspectRatio(contentMode: .fill)
//                       .background(Color.black)
                    
                    
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


//struct ShopNewProductViews: View {
//    var activityResources: ActivityResource
//    
//    var body: some View {
//        GeometryReader { g in
//            ZStack {
//                VStack (alignment: .leading){
//                    Text(self.activityResources.resourceName)
//                        .padding(.top, 18)
//                        .padding(.leading, 18)
//                        .font(.system(size: 20, weight: .bold, design: Font.Design.default))
//                        .foregroundColor(Color.black)
//                    Text(self.activityResources.resourceDescription)
//                        .padding(.leading, 18)
//                        .padding(.trailing, 18)
//                        .font(.system(size: 14))
//                        .foregroundColor(Color.black)
//                    
//                        
//                    ScrollView (.horizontal, showsIndicators: false) {
//                        HStack (spacing: 10) {
//                            ForEach(self.activityResources.resources, id: \.id) { item in
//                                ActivityResourceItems(resourceItems: item)
//                                                    .frame(width: 150, height: 200)
//                            }
//                            
//                        }.padding(.leading, 18)
//                        .padding(.trailing, 18)
//                            .padding(.top, 25)
//                    }
//                    
//                     Spacer()
//                }
//                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//                .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
//                .cornerRadius(10)
//                
//            }
//        }
//    }
//
//struct ActivityResourceItems: View {
//    var resourceItems: ActivityResourcesItem
//    var body: some View {
//        GeometryReader { g in
//            ZStack{
//                Image("\(self.resourceItems.resourceImage)")
//                .resizable()
//                .opacity(0.8)
//                .aspectRatio(contentMode: .fill)
//                .background(Color.black)
//                VStack(alignment: .center) {
//
//                    Text(self.resourceItems.resourceName)
//                        .font(.system(size: 16, weight: .bold, design: Font.Design.default))
//                        .frame(width: 150)
//                        .foregroundColor(Color.white)
//                        .multilineTextAlignment(.center)
//                }
//                        
//            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//            .cornerRadius(10)
//        }
//    }
//}
