//
//  PlaceDetailView.swift
//  SwiftUIStarterKitApp
//
//  Created by Osama Naeem on 11/08/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import SwiftUI
import Combine

//class SelectedPoint: ObservableObject {
//    @Published var selectedIndex: Int = 0
//}

struct ListingDetailView : View {
    @Binding var isShowing: Bool
    @Binding var placeItem: ListingInformation?
    let defaultPoint = ListingInformation(id: 0, listingName: "Default", listingDesc: "Default", seller: "Seller", price: 0.00, image: "Default PlaceHolder")
    
    @ObservedObject var selectedPoint = SelectedPoint()
    
    var body: some View {
        GeometryReader { g in
            ZStack {
                Image(self.placeItem?.image ?? "")
                    .resizable()
                    .frame(width: g.size.width, height: g.size.height)
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.3)
                    .background(Color.black)
                    .onDisappear {
                        self.isShowing = false
                }
                
                VStack(alignment: .leading) {
                    Text(self.placeItem?.listingName ?? "")
                        .foregroundColor(Color.white)
                        .font(.system(size: 30, weight: .bold, design: .default))
                        .padding(.top, 34)
                        .padding(.leading, 30)
                    HStack{
                        Spacer()
                    }
                    
                    Spacer()
                    
                    ListingDetail(listingInfo: self.placeItem ?? self.defaultPoint)
                        .padding(.bottom, 50)
//                    
//                    ZStack {
//                        BlurView(style: .light)
//                            .frame(width: g.size.width, height: 130)
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack {
//                                ForEach(self.placeItem?.famousPointsArray ?? [], id: \.id) { item in
//                                    PlacesCircleView(placeItems: item, selectedPoint: self.selectedPoint)
//                                }
//                            }.frame(width: g.size.width, height: 130)
//                        }
//                    }.padding(.bottom, 50)
                    
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ListingDetail: View {
    var listingInfo: ListingInformation
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(listingInfo.listingName)
                .foregroundColor(Color.white)
                .font(.system(size: 20, weight: .bold, design: Font.Design.default))
                .padding(.bottom, 24)
            HStack{
                Text("Seller user: " + listingInfo.seller)
                Spacer()
                Text("$ \(listingInfo.price, specifier: "%.2f")")
            }
            Text(listingInfo.listingDesc)
        }
    }
}
