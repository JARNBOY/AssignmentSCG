//
//  Constants.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import SwiftUI


//MARK: View property
var limitLineDescText: Int = 6
var maxRowImageHight: CGFloat = 200
var maxDetailImageHight: CGFloat = 360

//MARK: View function
func setNavigationThemeColor() {
    UINavigationBar.appearance().barTintColor = UIColor(Color("GreenAppThemeColor"))
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(.white)]
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(.white)]

}


