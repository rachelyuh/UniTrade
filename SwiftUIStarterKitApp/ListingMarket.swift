//
//  ActivitiesMockStore.swift
//  SwiftUIStarterKitApp
//
//  Created by Osama Naeem on 06/08/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import FirebaseDatabaseSwift
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage



class ListingMarket {
    var activityData: [ListingData] = [
        
        ListingData(id: 0, activitiesPlaces:
                        [ListingInformation(id: "0", listingName: "Used Bike", listingDesc: "sample description", seller: "abc123", price: 150, image: Data()),
                         
                        ])]
    //            //products
    //            ListingData(id: 1, activitiesPlaces:
    //                            [ListingInformation(id: "0", listingName: "Used Bike", listingDesc: "sample description", seller: "abc123", price: 150, image: "snowbird"),
    //                             ListingInformation(id: "1", listingName: "Product 2", listingDesc: "sample description", seller: "abc123", price: 150, image: "snowbird"),
    //                             ListingInformation(id: "2", listingName: "Product 3", listingDesc: "sample description", seller: "abc123", price: 150, image: "snowbird")
    //                ]),
    //            //services
    //            ListingData(id: 2, activitiesPlaces:
    //                            [ListingInformation(id: "0", listingName: "Photographer", listingDesc: "price rates are variable", seller: "abc123", price: 20, image: "camera"),
    //                             ListingInformation(id: "1", listingName: "Service 2", listingDesc: "sample description", seller: "abc123", price: 150, image: "camera"),
    //                             ListingInformation(id: "2", listingName: "Service 3", listingDesc: "sample description", seller: "abc123", price: 150, image: "camera")
    //                ])]
    
    
    func setListingInformation() {
        print("in setListingInformation function")
        print("in dispatch queue")
        getDataFrom(sellingType: "Products") { productData in
            print("Products data retrieved")
            self.activityData.append(ListingData(id: 1, activitiesPlaces: productData))
        }
        getDataFrom(sellingType: "Services") { productData in
            print("Services data retrieved")
            self.activityData.append(ListingData(id: 2, activitiesPlaces: productData))
            
        }
            
            
        
    }
    
    func getUserData(username: String){
                // Reference to your Firebase Database
            // Reference to your Firebase Database
            let databaseRef = Database.database().reference()

                    // Reference to the location you want to read from (e.g., a specific node or key)
            let specificRef = databaseRef.child("UserProfiles").child(username)

                    // Observe changes in the specified location
            specificRef.observe(.value) { (snapshot) in
                        // Check if the snapshot has any data
                guard let value = snapshot.value as? [String: Any] else {
                    print("No data in this location.")
                    return
                }

                        // Loop through the keys and values and print them
                for (key, value) in value {
                    print("\(key): \(value)")
                }
            }
        }
    func getDataFrom(sellingType: String, completion: @escaping ([ListingInformation]) -> Void) {
        print("getDataFrom info")
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let storageRef = Storage.storage().reference()
        let recentPostsQuery = (ref?.child(sellingType).queryLimited(toFirst: 100))!
        print(recentPostsQuery)
        var listingInformationArray: [ListingInformation] = []
        print("before observing")
        
        let dispatchGroup = DispatchGroup() // Create a DispatchGroup
        dispatchGroup.enter() // Enter the DispatchGroup
        recentPostsQuery.observe(.value) { (snapshot) in
          
            

            // Handle the data returned in the snapshot
            if snapshot.exists() {
                let totalChildrenCount = snapshot.childrenCount
                for (index, child) in snapshot.children.enumerated() {
                    if let childSnapshot = child as? DataSnapshot,
                       let data = childSnapshot.value as? [String: Any] {
                        let id = data["objectId"] as? String ?? "N/A"
                        print(id)
                        dispatchGroup.enter()
                        let listingName = data["productName"] as? String ?? "N/A"
                        let listingDesc = data["description"] as? String ?? "N/A"
                        let seller = data["username"] as? String ?? "N/A"
                        let price = data["price"] as? Float ?? 0.0
                        let path = data["image"] as? String ?? "N/A"
                        let fileRef = storageRef.child(path)
                        fileRef.getData(maxSize: 5*1024*1024) { data, error in
                            if error == nil && data != nil {
                                listingInformationArray.append(ListingInformation(id: id, listingName: listingName, listingDesc: listingDesc, seller: seller, price: price, image: data ?? Data()))
                                print("After:")
                                print(listingInformationArray)
                                dispatchGroup.leave()
                            }
                            
                        }
                       
                    }
                    if index == totalChildrenCount - 1 {
                                   // This is the last child, and all tasks are done
                        dispatchGroup.leave()
                               }
                    
                }
                
            } else {
                print("No data found")
                // Call the completion handler with an empty array to indicate no data
                dispatchGroup.leave() // Leave the DispatchGroup if no data is found
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            // This closure is executed after all DispatchGroup tasks are completed
            print("tasks complete")
            completion(listingInformationArray)
        }
    }
    
//    
//    func getDataFrom(sellingType: String) -> [ListingInformation]{
//           var ref: DatabaseReference!
//           ref = Database.database().reference()
//           let storageRef = Storage.storage().reference()
//           let recentPostsQuery = (ref?.child(sellingType).queryLimited(toFirst: 100))!
//           print(recentPostsQuery)
//           var ListingInformationArray: [ListingInformation] = []
//           
//        DispatchQueue.main.async {
//            recentPostsQuery.observe(.value) { (snapshot) in
//                // Handle the data returned in the snapshot
//                if snapshot.exists() {
//                    for child in snapshot.children {
//                        if let childSnapshot = child as? DataSnapshot,
//                           let data = childSnapshot.value as? [String: Any] {
//                            print(data)
//                            let id = data["objectId"] as? String ?? "N/A"
//                            print(id)
//                            let listingName = data["productName"] as? String ?? "N/A"
//                            let listingDesc = data["description"] as? String ?? "N/A"
//                            let seller = data["username"] as? String ?? "N/A"
//                            let price = data["price"] as? Float ?? 0.0
//                            let path = data["image"] as? String ?? "N/A"
//                            let fileRef = storageRef.child(path)
//                            fileRef.getData(maxSize: 5*1024*1024) { data, error in
//                                if error == nil && data != nil {
//                                    ListingInformationArray.append(ListingInformation(id: id, listingName: listingName, listingDesc: listingDesc, seller: seller, price: price, image: data ?? Data()))
//                                    print("Top")
//                                    print(ListingInformationArray)
//                                    print("Bottom")
//                                    
//                                }
//                                
//                                
//                            }
//                            
//                            // Continue processing or displaying the data
//                        }
//                        print(ListingInformationArray)
//                        
//                    }
//                } else {
//                    print("No data found")
//                }
//            }
//        }
//            return ListingInformationArray
//       }
//        
        
        static let listings: [ListingType] = [
            ListingType(id: 0, activityName: "ALL", activityNameLabel: "All", activityImage: "Chamonix", selectedActivity: false),
            ListingType(id: 1, activityName: "PRODUCT", activityNameLabel: "Product", activityImage: "boots", selectedActivity: false),
            ListingType(id: 2, activityName: "SERVICE", activityNameLabel: "Service", activityImage: "cameras", selectedActivity: false)
        ]
        
        
    
}
