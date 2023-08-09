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
    
    
    //MARK: BODY
    var body: some View {
        ForEach(self.articles, id: \.id) { article in
            
            NavigationLink(destination: DetailNewsView(article: article)
                .hideNavigationBarBsforeDestinationViewLink()
            ) {
                RowNewsView( article: article )
            }
        }//: ForEach
        
    }
}

struct ListDailyNewsView_Previews: PreviewProvider {
    static var previews: some View {
        @State var vm = DailyNewsViewModel()
        @State var isLoading: Bool = false
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    ListDailyNewsView(articles: dataNewsMock.articles)
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
            }
        }
    }
}
