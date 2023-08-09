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
    @State private var isAnimating: Bool = false
    @State var offsetImageScale: CGFloat = 0
    //MARK: BODY
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .center, spacing: 8) {
                    //MARK: HeaderView
                    GeometryReader { proxy -> AnyView in
                        
                        //Sticky Header
                        let minY = proxy.frame(in: .global).minY
                        
                        DispatchQueue.main.async {
                            self.offsetImageScale = minY
                        }
                        
                        return AnyView (
                            ZStack {
                                AsyncImage(
                                    url: URL(string: article.urlToImage ?? ""),
                                    content: { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: gotRect().width ,height: minY > 0 ? 200 + minY : nil)
                                    },
                                    placeholder: {
                                        ProgressView()
                                    }
                                )
                                .frame(height: minY > 0 ? 200 + minY : nil)
                                .scaleEffect(isAnimating ? 1.0 : 0.6)
                            }
                            
                        )
                        
                    }//: HeaderView
                    .frame( height: 200)
                    
                    //MARK: Description
                    VStack {
                        //MARK: Title
                        Text(article.title ?? "")
                            .modifier(TitleModifier())
                            .padding(.top)
                            .padding(.horizontal)
                            .opacity(isAnimating ? 1 : 0)
                        
                        //MARK: Desc
                        Text(article.description ?? "")
                            .modifier(DsecModifier())
                            .padding(.horizontal)
                            .opacity(isAnimating ? 1 : 0)
                        
                        //MARK: Date
                        Text("Updated: \((article.publishedAt ?? "").toDateNewsDisplay())")
                            .modifier(DateTextModifier())
                            .padding(.horizontal)
                            .opacity(isAnimating ? 1 : 0)
                        
                        //MARK: Spacer White Bottom
                        SpaceTextScaleView()
                        
                        Spacer()
                    }//: VStack
                    .offset(y : 100)
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
        .onAppear {
            isAnimating.toggle()
        }
        
    }
}

struct DetailNewsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailNewsView(article: dataArticleMock)
    }
}
