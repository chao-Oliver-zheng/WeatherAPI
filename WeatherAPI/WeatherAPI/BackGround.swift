//
//  BackGround.swift
//  WeatherAPI
//
//  Created by Oliver Zheng on 6/27/23.
//

import SwiftUI

struct BackGround: View {
    var body: some View {
        LinearGradient(
            colors:[.blue, .yellow],
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
            .ignoresSafeArea(.all)
    }
}

struct BackGround_Previews: PreviewProvider {
    static var previews: some View {
        BackGround()
    }
}
