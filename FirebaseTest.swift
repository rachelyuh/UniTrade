//
//  FirebaseTest.swift
//  SwiftUIStarterKitApp
//
//  Created by Matthew Lu on 10/14/23.
//  Copyright © 2023 NexThings. All rights reserved.
//

import Firebase

class FirebaseTest: ObservableObject{
    
    func keyExistsInFirebase(key: String, completion: @escaping (Bool) -> Void) {
            // Reference to your Firebase Database
            let databaseRef = Database.database().reference()

            // Reference to the location you want to check (e.g., a specific node or key)
            let specificRef = databaseRef.child("UserProfiles").child(key)

            specificRef.observeSingleEvent(of: .value) { snapshot in
                if snapshot.exists() {
                    // The key exists in Firebase
                    completion(true)
                } else {
                    // The key does not exist in Firebase
                    completion(false)
                }
            }
        }



}
//import Foundation
//import FirebaseDatabase
//import FirebaseDatabaseSwift
//
//class FirebaseTest: ObservableObject{
//    
//    private let ref = Database.database().reference()
//    
//    var accountExists = false
//    
//    func checkExist(usaname: String) -> Bool{
//        
//        self.ref.child("UserProfiles").observeSingleEvent(of: .value, with: { snapshot in
//          // Get user value
//            let userValue = snapshot.value as! [String:Any]
//            for (eachUser,_) in userValue {
////                print("username: " + eachUser)
////                print("usaname: " + usaname)
////                print("match: " + String(usaname == eachUser))
//                if (usaname == eachUser) {
//                    self.accountExists = true
//                    break
//                } else {
//                    self.accountExists = false
//                }
//            }
//        })
//        
//        return self.accountExists
//    }
//    
//}
//                                                     
