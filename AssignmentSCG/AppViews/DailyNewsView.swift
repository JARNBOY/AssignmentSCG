//
//  ContentView.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import SwiftUI

struct DailyNewsView: View {
    
    init() {
        //set color NavigationBar
        setNavigationThemeColor()
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                }//: VStack
                .padding()
                .frame(height: 900)
                .navigationTitle("News")
            }//: ScrollView
            
        }//: NavigationView
        
    }
}

struct DailyNewsView_Previews: PreviewProvider {
    static var previews: some View {
        DailyNewsView()
    }
}
