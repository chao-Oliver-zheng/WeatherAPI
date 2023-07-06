//
//  EmptyView.swift
//  WeatherAPI
//
//  Created by Oliver Zheng on 6/27/23.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        
        VStack{
            VStack {
                Text("Welcome 😊")
                Text("Search for a city/state in USA above")
            }
            HStack{
                Spacer()
                Image(systemName: "cloud.sun")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .padding()
    }
}


struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
