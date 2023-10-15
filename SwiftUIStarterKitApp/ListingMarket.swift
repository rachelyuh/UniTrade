//
//  ActivitiesMockStore.swift
//  SwiftUIStarterKitApp
//
//  Created by Osama Naeem on 06/08/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import SwiftUI

class ListingMarket {
    
    static let listings: [ListingType] = [
        ListingType(id: 0, activityName: "ALL", activityNameLabel: "All", activityImage: "Chamonix", selectedActivity: false),
        ListingType(id: 1, activityName: "PRODUCT", activityNameLabel: "Product", activityImage: "boots", selectedActivity: false),
        ListingType(id: 2, activityName: "SERVICE", activityNameLabel: "Service", activityImage: "cameras", selectedActivity: false)
    ]
    
    static let activityData: [ListingData] = [
        
        ListingData(id: 0, activitiesPlaces:
                        [ListingInformation(id: 0, listingName: "Used Bike", listingDesc: "sample description", seller: "abc123", price: 150, image: "snowbird"),
                         ListingInformation(id: 1, listingName: "Product 2", listingDesc: "sample description", seller: "abc123", price: 150, image: "snowbird"),
                         ListingInformation(id: 2, listingName: "Product 3", listingDesc: "sample description", seller: "abc123", price: 150, image: "snowbird")
            ]),
        ListingData(id: 1, activitiesPlaces:
                        [ListingInformation(id: 0, listingName: "Used Bike", listingDesc: "sample description", seller: "abc123", price: 150, image: "snowbird"),
                         ListingInformation(id: 1, listingName: "Product 2", listingDesc: "sample description", seller: "abc123", price: 150, image: "snowbird"),
                         ListingInformation(id: 2, listingName: "Product 3", listingDesc: "sample description", seller: "abc123", price: 150, image: "snowbird")
            ]),
        ListingData(id: 2, activitiesPlaces:
                        [ListingInformation(id: 0, listingName: "Photographer", listingDesc: "price rates are variable", seller: "abc123", price: 20, image: "camera"),
                         ListingInformation(id: 1, listingName: "Service 2", listingDesc: "sample description", seller: "abc123", price: 150, image: "camera"),
                         ListingInformation(id: 2, listingName: "Service 3", listingDesc: "sample description", seller: "abc123", price: 150, image: "camera")
            ])]
}
