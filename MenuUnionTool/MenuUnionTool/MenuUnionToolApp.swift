//
//  MenuUnionToolApp.swift
//  MenuUnionTool
//
//  Created by 石原脩平 on 2025/01/13.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
      FirebaseApp.configure()
      let db = Firestore.firestore()

      // コレクションを作成
      db.collection("items").document("new-item3").setData([
        "name": "新しいアイテム2",
        "price": 1002,
      ])
      
      return true
  }
}

@main
struct MenuUnionToolApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
