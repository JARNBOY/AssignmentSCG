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
    
    //MARK: BODY
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 8) {
                    //MARK: ImageNewsView
                    ImageNewsView(
                        contentMode: .fill,
                        maxHeight: maxDetailImageHight,
                        urlString: imageURLMock
                    )
                    
                    //MARK: Title
                    Text("Ukrainian drones intercepted across Russia, military says - CNN")
                        .modifier(TitleModifier())
                        .padding(.top)
                        .padding(.horizontal)
                    
                    //MARK: Desc
                    Text("Three drones were intercepted in “Moscow City” in an attempted attack on Sunday on the business and shopping development in the west of the Russian capital, Russia’s Ministry of Defense said.")
                        .modifier(DsecModifier())
                        .padding(.horizontal)
                    
                    //MARK: Date
                    Text("Updated: Dec 07, 03:04")
                        .modifier(DateTextModifier())
                    
                    //MARK: Spacer White Bottom
                    SpaceTextScaleView()
                    
                    Spacer()
                }//: VStack
                .navigationBarTitle("Detail", displayMode: .inline)
                .navigationBarHidden(false)
                .background(.white)
                
            }//: ScrollView
            
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
        DetailNewsView()
    }
}
