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
    
    var article: Article
    var isLastRow : Bool
    @StateObject var vm : DailyNewsViewModel
    @State private var isAnimating: Bool = false
    
    //MARK: BODY
    public var body: some View {
        HStack {
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
                    .opacity(isAnimating ? 1 : 0)
                
                //MARK: Desc
                Text(article.description ?? "")
                    .modifier(DsecModifier())
                    .lineLimit(isDescLimitLine ? limitLineDescText : nil)
                    .opacity(isAnimating ? 1 : 0)
                
                //MARK: Date
                Text("Updated: \((article.publishedAt ?? "").toDateNewsDisplay())")
                    .modifier(DateTextModifier())
                    .opacity(isAnimating ? 1 : 0)
                
                
                Divider()
                    .padding(.vertical)
            }//: VStack
            .frame(width: .infinity)
            
//            Image(systemName: "chevron.forward")
//                .fontWeight(.bold)
//                .foregroundColor(.black)
        }
        .frame(width: .infinity)
        .padding()
        .onAppear {
            isAnimating = true
            if isLastRow {
                Task {
                    print("isLastRow naja")
                    await vm.requestNews(currentArticle: article)
                }
                
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        RowNewsView(article: dataArticleMock, isLastRow: false, vm: DailyNewsViewModel())
    }
}
