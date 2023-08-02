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
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ListDailyNewsView(articles: dataNewsMock.articles)
                }
            }
        }
    }
}
