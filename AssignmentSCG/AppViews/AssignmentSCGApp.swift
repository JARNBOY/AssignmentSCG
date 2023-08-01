//
//  AssignmentSCGApp.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import SwiftUI

@main
struct AssignmentSCGApp: App {
    
    init() {
        //set color NavigationBar
        setNavigationThemeColor()
    }
    
    var body: some Scene {
        WindowGroup {
            DailyNewsView()
        }
    }
}
