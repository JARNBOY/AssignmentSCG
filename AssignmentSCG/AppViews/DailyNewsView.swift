//
//  ContentView.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import SwiftUI

struct DailyNewsView: View {
    //MARK: PROPERTY
    @State var news: News = dataNewsMock
    
    @State private var searchText: String = ""
    
    
    //MARK: BODY
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    //MARK: SearchView
                    SearchView(searchText: $searchText)
                    
                    Spacer()
                    //MARK: ListDailyNewsView
                    ForEach(news.articles, id: \.id) { article in
                        NavigationLink(destination: DetailNewsView()
                            .hideNavigationBarBsforeDestinationViewLink()
                        ) {
                            RowNewsView()
                        }
                    }
                    
                }//: VStack
                .navigationTitle("News")
                .background(Color.white)
            }//: ScrollView
            .background(Color("GreenAppThemeColor"))
        }//: NavigationView
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct DailyNewsView_Previews: PreviewProvider {
    static var previews: some View {
        DailyNewsView()
    }
}
