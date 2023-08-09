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
    var urlString: String
    
    @State private var isAnimatingImage: Bool = false
    //MARK: BODY
    
    var body: some View {
        AsyncImage(
            url: URL(string: urlString),
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: contentMode)
                    .frame(maxHeight: maxHeight)
            },
            placeholder: {
                ProgressView()
            }
        )
        .scaleEffect(isAnimatingImage ? 1.0 : 0.6)
        .onAppear() {
          withAnimation(.easeOut(duration: 0.5)) {
            isAnimatingImage = true
          }
        }
    }
}

struct ImageNewsView_Previews: PreviewProvider {
    static var previews: some View {
        ImageNewsView(contentMode: .fill, maxHeight: 360, urlString: imageURLMock)
    }
}
