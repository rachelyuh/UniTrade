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
