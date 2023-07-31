//
//  DateTextModifier.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import SwiftUI

struct DateTextModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.body)
      .foregroundColor(Color.gray)
  }
}
