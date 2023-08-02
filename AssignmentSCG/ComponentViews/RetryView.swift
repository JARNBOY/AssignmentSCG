//
//  RetryView.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 2/8/2566 BE.
//

import SwiftUI

struct RetryView: View {
    //MARK: PROPERTY
    var errorDescription: String
    
    //MARK: BODY
    var body: some View {
        VStack {
            Image(systemName: "arrow.counterclockwise.icloud.fill")
                .font(.system(.largeTitle, design: .default, weight: .bold))
            
            Text("Retry")
            
            if !errorDescription.isEmpty {
                Text("Error : \(errorDescription)")
                    .padding()
            }
        }
        .foregroundColor(.accentColor)
    }
}

struct RetryView_Previews: PreviewProvider {
    static var previews: some View {
        RetryView(errorDescription: "")
    }
}
