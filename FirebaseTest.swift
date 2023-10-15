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
    
    func userPasswordMatch(username: String, password: String, completion: @escaping (Bool) -> Void) {
            // Reference to your Firebase Database
        if (username == "" && password == "") {
            completion(false)
            return
        }
        let databaseRef = Database.database().reference()

            // Reference to the location you want to check (e.g., a specific node or key)
        let specificRef = databaseRef.child("UserProfiles")

        specificRef.observeSingleEvent(of: .value) { snapshot in
            if snapshot.hasChild(username) {
                    // The key exists in Firebase
                let childSnapshot = snapshot.childSnapshot(forPath: username)
                if let keyData = childSnapshot.value as? [String: Any], let storedValue = keyData["password"] as? String {
                    if (storedValue == password) {
                        completion(true)
                    } else {
                        completion(false)
                    }
                } else {
                        // The key exists, but the value does not match
                    completion(false)
                }
            } else {
                // The key does not exist in Firebase
                completion(false)
            }
        }
    }
    
    func getUserData(username: String, completion: @escaping ([String: Any]?) -> Void){
    
            // Reference to your Firebase Database
        // Reference to your Firebase Database
        let databaseRef = Database.database().reference()

                // Reference to the location you want to read from (e.g., a specific node or key)
        let specificRef = databaseRef.child("UserProfiles").child(username)

        // Observe changes in the specified location
        specificRef.observeSingleEvent(of: .value) { snapshot in
                if let value = snapshot.value as? [String: Any] {
                    
                    // Successfully retrieved data and cast it to a dictionary
                    completion(value)
                } else {
                    // Data retrieval failed or is not in the expected format
                    completion(nil)
                }
            }
    }
    
    func getProductData(completion: @escaping ([String: Any]?) -> Void){
            // Reference to your Firebase Database
        // Reference to your Firebase Database
        let databaseRef = Database.database().reference()

                // Reference to the location you want to read from (e.g., a specific node or key)
        let specificRef = databaseRef.child("Products")

        // Observe changes in the specified location
        specificRef.observeSingleEvent(of: .value) { snapshot in
                if let value = snapshot.value as? [String: Any] {
                    // Successfully retrieved data and cast it to a dictionary
                    completion(value)
                } else {
                    // Data retrieval failed or is not in the expected format
                    completion(nil)
                }
            }
    }
    
    func getServiceData(completion: @escaping ([String: Any]?) -> Void){
            // Reference to your Firebase Database
        // Reference to your Firebase Database
        let databaseRef = Database.database().reference()

                // Reference to the location you want to read from (e.g., a specific node or key)
        let specificRef = databaseRef.child("Services")

        // Observe changes in the specified location
        specificRef.observeSingleEvent(of: .value) { snapshot in
                if let value = snapshot.value as? [String: Any] {
                    // Successfully retrieved data and cast it to a dictionary
                    completion(value)
                } else {
                    // Data retrieval failed or is not in the expected format
                    completion(nil)
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
