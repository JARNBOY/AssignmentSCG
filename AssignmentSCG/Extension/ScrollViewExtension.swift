//
//  ScrollViewExtension.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 2/8/2566 BE.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}
