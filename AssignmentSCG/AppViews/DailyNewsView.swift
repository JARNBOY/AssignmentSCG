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
    @State private var point: CGSize = CGSize()
    @State private var scrollPosition: CGPoint = .zero
    @StateObject private var vm = DailyNewsViewModel()
    
    //MARK: BODY
    var body: some View {
        NavigationView {
            //use GeometryReader for find current row
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
                        }//: ForEach
                    } else {
                        //MARK: EmptyAndRetryView
                        SpaceTextScaleView()
                    }
                }//: VStack
                .navigationTitle("News")
                .background(Color.white)
                .background(GeometryReader { geometry in
                    Color.clear
                        .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
                })
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    self.scrollPosition = value
                    print("scrollPosition: \(scrollPosition)")
                    
                }
                
            }//: ScrollView
            .background(Color("GreenAppThemeColor"))
            .coordinateSpace(name: "scroll")
            
            
        }//: NavigationView
        .edgesIgnoringSafeArea(.all)
        .task {
            await vm.requestNews()
        }
        
    }
}
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}

struct DailyNewsView_Previews: PreviewProvider {
    static var previews: some View {
        DailyNewsView()
    }
}
