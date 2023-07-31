//
//  RowNewsView.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import SwiftUI

struct RowNewsView: View {
    //MARK: PROPERTY
    private var alignment: HorizontalAlignment = .center
    private var isDescLimitLine: Bool = true
    private var isDetailView: Bool = true
    
//    @Binding var isTapOpenDetailView: Bool?
    
    //MARK: BODY
    var body: some View {
        VStack(alignment: alignment,spacing: 8) {
            
            //MARK: ImageNewsView
            ImageNewsView(contentMode: .fit, maxHeight: maxRowImageHight)
                .cornerRadius(10)
            
            //MARK: Title
            Text("Ukrainian drones intercepted across Russia, military says - CNN")
                .modifier(TitleModifier())
                .padding(.top)
            
            //MARK: Desc
            Text("Three drones were intercepted in “Moscow City” in an attempted attack on Sunday on the business and shopping development in the west of the Russian capital, Russia’s Ministry of Defense said.")
                .modifier(DsecModifier())
                .lineLimit(isDescLimitLine ? limitLineDescText : nil)
            
            //MARK: Date
            Text("Updated: Dec 07, 03:04")
                .modifier(DateTextModifier())
            
            
            
            Divider()
                .padding(.vertical)
        }
        .padding()
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        RowNewsView()
    }
}
