//
//  ContentView.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import SwiftUI

struct DailyNewsView: View {
    //MARK: PROPERTY
    @State private var searchText: String = ""
    @StateObject private var vm = DailyNewsViewModel()
    
    //MARK: BODY
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    //MARK: SearchView
                    SearchView(searchText: $searchText)
                    
                    Spacer()
                    
                    if let news = vm.news {
                        //MARK: ListDailyNewsView
                        ForEach(news.articles, id: \.title) { article in
                            NavigationLink(destination: DetailNewsView(article: article)
                                .hideNavigationBarBsforeDestinationViewLink()
                            ) {
                                RowNewsView(article: article)
                            }
                        }
                    } else {
                        //MARK: EmptyAndRetryView
                        SpaceTextScaleView()
                    }
                    
                    
                }//: VStack
                .navigationTitle("News")
                .background(Color.white)
            }//: ScrollView
            .background(Color("GreenAppThemeColor"))
            
        }//: NavigationView
        .edgesIgnoringSafeArea(.all)
        .task {
            await vm.requestNews()
        }
        
    }
}

struct DailyNewsView_Previews: PreviewProvider {
    static var previews: some View {
        DailyNewsView()
    }
}
