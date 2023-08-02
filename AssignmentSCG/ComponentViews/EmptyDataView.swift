//
//  EmptyDataView.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 2/8/2566 BE.
//

import SwiftUI

struct EmptyDataView: View {
    var body: some View {
        ZStack {
            VStack {
                SpaceTextScaleView()
            }
            .frame(maxWidth: .infinity)
            
            Text("Data is Empty")
        }
    }
}

struct EmptyDataView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyDataView()
            .background(.red)
    }
}
