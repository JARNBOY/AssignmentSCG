//
//  ImageNewsView.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import SwiftUI

struct ImageNewsView: View {
    //MARK: PROPERTY
    var contentMode: ContentMode
    var maxHeight: CGFloat
    
    //MARK: BODY
    
    var body: some View {
        AsyncImage(
            url: URL(string: "https://media.cnn.com/api/v1/images/stellar/prod/230729202313-02-moscow-city-drone-attack-0730.jpg?c=16x9&q=w_800,c_fill"),
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: contentMode)
                    .frame(maxHeight: maxHeight)
            },
            placeholder: {
                ProgressView()
            }
        )
    }
}

struct ImageNewsView_Previews: PreviewProvider {
    static var previews: some View {
        ImageNewsView(contentMode: .fill, maxHeight: 200)
    }
}
