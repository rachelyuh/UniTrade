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
    var viewModel = WriteData()
    
    @State
    var content: String = ""
    
    var body: some View{
        VStack{
            TextEditor(text: $content)
                .frame(width: .infinity, height: 50)
                .padding()
            Button {
                viewModel.pushNewProduct(objectId: content,  username: "fds", prodName: "fds", description: "AWESOME sofa", price: 4.32,  image: "fds",  category: ["electroni", "furniture"])
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
