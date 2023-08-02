//
//  SearchView.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import SwiftUI

struct SearchView: View {
    //MARK: PROPERTY
    @State private var searchText: String = ""
    
    @FocusState private var searchTextFieldIsFocused: Bool
    @StateObject var vm : DailyNewsViewModel
    
    //MARK: BODY
    var body: some View {
        HStack {
            HStack(spacing: 8) {
                
                //MARK: Search button
                Button {
                    Task {
                        await vm.searchNews(searchText: searchText)
                    }
                    self.searchTextFieldIsFocused = false
                } label: {
                    Image(systemName: "magnifyingglass")
                        .padding()
                }//: Button
                .foregroundColor(.gray)
                .frame(width: 30)

                //MARK: Textfield Search
                TextField(
                    "Placeholder",
                    text: $searchText,
                    onCommit: {
                        Task {
                            await vm.searchNews(searchText: searchText)
                        }
                    }
                )//: TextField
                .focused($searchTextFieldIsFocused)
                
                //MARK: Clear Button
                Button {
                    self.searchText = ""
                    self.searchTextFieldIsFocused = false
                    Task {
                        await vm.refreshNews()
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        
                }
                .foregroundColor(.accentColor)
                .padding(.all, 1)
                .opacity(searchText.isEmpty ? 0 : 1)
                .frame(width: searchText.isEmpty ? 0 : 30)
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
        
        SearchView(
            vm: DailyNewsViewModel()
        )
    }
}
