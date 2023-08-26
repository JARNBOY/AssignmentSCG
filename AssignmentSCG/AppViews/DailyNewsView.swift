//
//  ContentView.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import SwiftUI

struct DailyNewsView: View {
    //MARK: PROPERTY
    @State private var isScrolling: Bool = false
    @StateObject private var vm = DailyNewsViewModel()
    
    
    //MARK: BODY
    var body: some View {
        NavigationView {
            VStack {
                //MARK: SearchView
                SearchView(
                    vm: vm
                )
                .offset(y: -8)
                
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
                    ListDailyNewsView(
                        articles: vm.articles,
                        vm: vm
                    )
                    .opacity( vm.loadStatus == LoadStatus.loading ? 0.7 : 1 )
                    .animation(
                        Animation
                            .easeInOut
                        , value: vm.loadStatus == LoadStatus.loading
                    )
                    .overlay {
                        if vm.loadStatus == LoadStatus.loading {
                            ProgressView()
                        }
                    }
                    .refreshable {
                        Task {
                            await vm.refreshNews()
                        }
                    }
                    
                }
            }//: VStack
            .frame(minWidth: 400)
            .navigationBarTitle("News", displayMode: isScrolling ? .inline : .large)
            .background(Color.white)
            
            
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
