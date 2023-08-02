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
    @State private var isTextFieldDidEndEditing: Bool = false
    @State private var scrollPosition: CGPoint = .zero
    @StateObject private var vm = DailyNewsViewModel()
    
    //MARK: BODY
    var body: some View {
        NavigationView {
            //use GeometryReader for find current row
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    //MARK: SearchView
                    SearchView(
                        searchText: $searchText,
                        isTextFieldDidEndEditing: $isTextFieldDidEndEditing
                    )
                    .onSubmit {
                        Task {
                            if isTextFieldDidEndEditing {
                                await vm.searchNews(searchText: searchText)
                            }
                        }
                        
                    }
                    
                    
                    Spacer()
                    
                    //MARK: ListDailyNewsView
                    ListDailyNewsView(articles: vm.articles)
                    
                    //MARK: EmptyRetryView
                    
                }//: VStack
                .navigationTitle("News")
                .background(Color.white)
                .background(GeometryReader { geometry in
                    Color.clear
                        .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
                })
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    self.scrollPosition = value
                    if self.vm.isScrollNearLastRow(currentOffsetY: self.scrollPosition.y) {
                        Task {
                            await vm.requestNews(currentArticle: vm.lastRowArticle)
                        }
                    }
                }
            }//: ScrollView
            .background(Color("GreenAppThemeColor"))
            .coordinateSpace(name: "scroll")
            .refreshable {
                Task {
                    await vm.refreshNews()
                }
            }
            
        }//: NavigationView
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            Task {
                await vm.requestNews(currentArticle: nil)
            }
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
