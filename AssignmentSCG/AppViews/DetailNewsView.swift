//
//  DetailNewsView.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import SwiftUI

struct DetailNewsView: View {
    //MARK: PROPERTY
    @Environment(\.presentationMode) var presentationMode
    
    @State var article: Article
    
    //MARK: BODY
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 8) {
                    //MARK: ImageNewsView
                    ImageNewsView(
                        contentMode: .fill,
                        maxHeight: maxRowImageHight,
                        urlString: article.urlToImage ?? ""
                    )
                    
                    //MARK: Title
                    Text(article.title ?? "")
                        .modifier(TitleModifier())
                        .padding(.top)
                        .padding(.horizontal)
                    
                    //MARK: Desc
                    Text(article.description ?? "")
                        .modifier(DsecModifier())
                        .padding(.horizontal)
                    
                    //MARK: Date
                    Text("Updated: \((article.publishedAt ?? "").toDateNewsDisplay())")
                        .modifier(DateTextModifier())
                    
                    //MARK: Spacer White Bottom
                    SpaceTextScaleView()
                    
                    Spacer()
                }//: VStack
                .navigationBarTitle("Detail", displayMode: .inline)
                .navigationBarHidden(false)
                .background(.white)
                
            }//: ScrollView
            .padding(.top, 4)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.backward")
                            Text("Back")
                        }
                    }
                }
            }
            .foregroundColor(.white)
            .background(Color("GreenAppThemeColor"))
        }//: NavigationView
        
    }
}

struct DetailNewsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailNewsView(article: dataArticleMock)
    }
}
