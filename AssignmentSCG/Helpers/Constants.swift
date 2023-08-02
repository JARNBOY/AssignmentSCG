//
//  Constants.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 31/7/2566 BE.
//

import SwiftUI


//MARK: View property
var limitLineDescText: Int = 6
let heightFrameRowNews: Int = 500
var maxRowImageHight: CGFloat = 200
var maxDetailImageHight: CGFloat = 360
let formatDateTime = "yyyy-MM-dd'T'HH:mm:ssZ"
let formatDateNewsDisplay = "MMM dd, HH:mm"

//MARK: Param Endpoint Property
let countryParam: String = "country=us"
let apiKeyParam: String = "apiKey=0bfb7217d29740c3a8ca13fda1c95a49"
let apiKeyParam02: String = "apiKey=55c250f06e1144c29a3ec4d2530adbe5"

//MARK: View function
func setNavigationThemeColor() {
    UINavigationBar.appearance().barTintColor = UIColor(Color("GreenAppThemeColor"))
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(.white)]
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(.white)]

}


