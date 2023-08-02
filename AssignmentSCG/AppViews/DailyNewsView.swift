//
//  ContentView.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import SwiftUI

struct DailyNewsView: View {
    //MARK: PROPERTY
    @State private var scrollPosition: CGPoint = .zero
    @StateObject private var vm = DailyNewsViewModel()
    
    //MARK: BODY
    var body: some View {
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    //MARK: SearchView
                    SearchView(
                        vm: vm
                    )
                    
                    Spacer()
                    
                    if $vm.articles.isEmpty {
                        
                        if let error = vm.error {
                            
                            //MARK: RetryView
                            RetryView(errorDescription: error.errorDescription ?? "")
                                .onTapGesture {
                                    Task {
                                        await vm.refreshNews()
                                    }
                                }
                            
                        } else {
                            
                            //MARK: EmptyDataView
                            EmptyDataView()
                        }
                    } else {
                        
                        //MARK: ListDailyNewsView
                        ListDailyNewsView(articles: vm.articles)
                        
                    }
                }//: VStack
                .navigationTitle("News")
                .background(Color.white)
                .background(
                    //use GeometryReader for find current row
                    GeometryReader { geometry in
                        Color.clear
                            .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
                    }
                )
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

struct DailyNewsView_Previews: PreviewProvider {
    static var previews: some View {
        DailyNewsView()
    }
}
