//
//  GetData.swift
//  SwiftUIStarterKitApp
//
//  Created by Rachel Y on 10/14/23.
//  Copyright © 2023 NexThings. All rights reserved.
//


import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
//import FirebaseAuth
import Firebase


class GetData: ObservableObject{
    
    //gets data from data base and returns it as a list of listinginformation
    
    func getDataFrom(sellingType: String) -> [ListingInformation]{
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let storageRef = Storage.storage().reference()
        let recentPostsQuery = (ref?.child(sellingType).queryLimited(toFirst: 100))!
        print(recentPostsQuery)
        var ListingInformationArray: [ListingInformation] = []
        
        recentPostsQuery.observe(.value) { (snapshot) in
            // Handle the data returned in the snapshot
            if snapshot.exists() {
                for child in snapshot.children {
                    if let childSnapshot = child as? DataSnapshot,
                       let data = childSnapshot.value as? [String: Any] {
                        let id = data["objectID"] as? String ?? "N/A"
                        let listingName = data["productName"] as? String ?? "N/A"
                        let listingDesc = data["description"] as? String ?? "N/A"
                        let seller = data["username"] as? String ?? "N/A"
                        let price = data["price"] as? Float ?? 0.0
                        let path = data["image"] as? String ?? "N/A"
                        let fileRef = storageRef.child(path)
                        fileRef.getData(maxSize: 5*1024*1024) { data, error in
                            if error == nil && data != nil {
                                ListingInformationArray.append(ListingInformation(id: id, listingName: listingName, listingDesc: listingDesc, seller: seller, price: price, image: data ?? Data()))
                                
                            }
                        
                    }
               
                        // Continue processing or displaying the data
                    }
                }
            } else {
                print("No data found")
            }
        }
     

        return []

    }
        
    
    
}
