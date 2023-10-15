//
//  LogInView.swift
//  SwiftUIStarterKitApp
//
//  Created by Osama Naeem on 02/08/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import SwiftUI
import UIKit

struct LogInView: View {
    @EnvironmentObject var settings: UserSettings
    
    @State  private var emailAddress: String = ""
    @State  private var password: String = ""
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack (alignment: .center){
                    Spacer().frame(height: 150)
                    HStack {
                        Text("UniTrade")
                            .font(.system(size: 40, weight: .bold))
                        
                    }.padding(.top, 30)
                        .padding(.bottom, 10)
                    
                    Text("Log Into Your Account")
                        .font(.title)
                        .font(.system(size: 14, weight: .bold, design: Font.Design.default))
                        .padding(.bottom, 50)
                    
                    TextField("Email", text: self.$emailAddress)
                        .frame(width: geometry.size.width - 45, height: 50)
                        .textContentType(.emailAddress)
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                        .accentColor(.red)
                        .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                        .cornerRadius(5)
                    
                    
                    TextField("Password", text: self.$password)
                        .frame(width: geometry.size.width - 45, height: 50)
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                        .foregroundColor(.gray)
                        .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                        .textContentType(.password)
                        .cornerRadius(5)
                    
                    NavigationLink(destination: ContentView())
                    {
                        HStack {
                            Text("Log In")
                        }
                        .padding()
                        .frame(width: geometry.size.width - 40, height: 40)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(5)
                    }
                    .padding(.bottom, 0)
                    
                    Button(action: {
                        print("Take to forget password VC")
                    }) {
                        Text("Forgot your password?")
                    }
                    
                    Divider().padding(.bottom, 20)
                    
                    NavigationLink(destination: SignUpView()) {
                        Text("Create a new account")
                            .font(.system(size: 25))
                    }
                }
                .padding(.bottom, 90)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Previews_LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
