//
//  ListDailyNewsView.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 2/8/2566 BE.
//

import SwiftUI

struct ListDailyNewsView: View {
    //MARK: PROPERTY
    var articles: [Article]
    @StateObject var vm : DailyNewsViewModel
    
    //MARK: BODY
    var body: some View {
        List {
            ForEach(self.articles, id: \.id) { article in

                NavigationLink(destination: DetailNewsView(article: article)
                    .hideNavigationBarBsforeDestinationViewLink()
                ) {
                    let isLastRow: Bool = article.id == articles.last?.id && articles.count > 0
                    RowNewsView(
                        article: article,
                        isLastRow: isLastRow,
                        vm: vm)
                }
                .listRowSeparator(.hidden)
            }//: ForEach
            .foregroundColor(.black)
        }
        .listStyle(.plain)
        
        
        
//        ForEach(self.articles, id: \.id) { article in
//
//            NavigationLink(destination: DetailNewsView(article: article)
//                .hideNavigationBarBsforeDestinationViewLink()
//            ) {
//                RowNewsView( article: article )
//            }
//        }//: ForEach
        
    }
}

struct ListDailyNewsView_Previews: PreviewProvider {
    static var previews: some View {
        @State var isLoading: Bool = false
        
        NavigationView {
            ListDailyNewsView(
                articles: dataNewsMock.articles,
                vm: DailyNewsViewModel()
            )
            .opacity( isLoading ? 0.7 : 1 )
            .animation(
                Animation
                    .easeInOut(duration: 4)
                , value: isLoading
            )
            .overlay {
                if isLoading {
                    ProgressView()
                }
            }
            
        }
        
//        NavigationView {
//            ScrollView(.vertical, showsIndicators: false) {
//                ListDailyNewsView(articles: dataNewsMock.articles)
//                    .opacity( isLoading ? 0.7 : 1 )
//                    .animation(
//                        Animation
//                        .easeInOut(duration: 4)
//                        , value: isLoading
//                    )
//                    .overlay {
//                        if isLoading {
//                            ProgressView()
//                        }
//                    }
//            }
//        }
    }
}
