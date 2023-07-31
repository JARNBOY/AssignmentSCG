//
//  Navigation.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import SwiftUI

extension View {
    func hideNavigationBarBsforeDestinationViewLink() -> some View {
        self
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}
