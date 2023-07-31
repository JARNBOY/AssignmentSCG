//
//  TitleModifier.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20))
            .fontWeight(.bold)
            .foregroundColor(Color("GreenTitleSectionColor"))
    }
}
