//
//  WriteView.swift
//  SwiftUIStarterKitApp
//
//  Created by Ben Kim on 10/13/23.
//  Copyright © 2023 NexThings. All rights reserved.
//

import Foundation
import SwiftUI


struct WriteView: View{
    
    @StateObject
    var viewModel = FirebaseTest()
    
    @State
    var content: String = ""
    
    var body: some View{
        VStack{
            TextEditor(text: $content)
                .frame(width: .infinity, height: 50)
                .padding()
            Button {
                viewModel.keyExistsInFirebase(key: content) { exists in
                    if exists {
                        print("The key exists in Firebase")
                    } else {
                        print("The key does not exist in Firebase")
                    }
                }
            } label: {
                Text("Push")
                    .padding()
            }

        }.frame(width: .infinity, alignment: .top)
    }
}

struct Write_Preview: PreviewProvider{
    static var previews: some View{
        WriteView()
    }
    
}
