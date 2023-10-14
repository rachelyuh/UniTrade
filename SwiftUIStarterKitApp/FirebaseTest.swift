//
//  FirebaseTest.swift
//  SwiftUIStarterKitApp
//
//  Created by Ben Kim on 10/13/23.
//  Copyright © 2023 NexThings. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class FirebaseTest: ObservableObject{
    
    private let ref = Database.database().reference()
    
    func pushNewValue(value: String){
        ref.setValue(value)
    }
    
}
