//
//  RowNewsView.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import SwiftUI

public struct RowNewsView: View {
    //MARK: PROPERTY
    private let alignment: HorizontalAlignment = .center
    private let isDescLimitLine: Bool = true
    private let isDetailView: Bool = true
    
    @State var article: Article
    
    //MARK: BODY
    public var body: some View {
        VStack(alignment: alignment,spacing: 8) {
            
            //MARK: ImageNewsView
            ImageNewsView(
                contentMode: .fit,
                maxHeight: maxRowImageHight,
                urlString: article.urlToImage ?? ""
            )
                .cornerRadius(10)
            
            //MARK: Title
            Text(article.title ?? "")
                .modifier(TitleModifier())
                .padding(.top)
            
            //MARK: Desc
            Text(article.description ?? "")
                .modifier(DsecModifier())
                .lineLimit(isDescLimitLine ? limitLineDescText : nil)
            
            //MARK: Date
            Text("Updated: \((article.publishedAt ?? "").toDateNewsDisplay())")
                .modifier(DateTextModifier())
            
            
            
            Divider()
                .padding(.vertical)
        }
        .padding()
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        RowNewsView(article: dataArticleMock)
    }
}
