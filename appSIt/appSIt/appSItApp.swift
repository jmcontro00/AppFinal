//
//  appSItApp.swift
//  appSIt
//
//  Created by Amieva on 04/05/23.
//

import SwiftUI
import Firebase

@main
struct appSItApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
