//
//  SearchView.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import SwiftUI

struct SearchView: View {
    //MARK: PROPERTY
    @Binding var searchText: String
    
    //MARK: BODY
    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .frame(width: 20, height: 20, alignment: .leading)
                    .foregroundColor(.gray)
                    .padding(.leading, 4)

                TextField("Placeholder", text: $searchText)
            }//: HStack
            .frame(height: 40)
            .padding(.vertical, 4)
            .background( Color.white)
            .cornerRadius(8)
        }//: HStack
        .frame(height: 60)
        .padding(.horizontal, 16)
        .background( Color.gray)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        @State var searchText: String = ""
        
        SearchView(searchText: $searchText)
    }
}
