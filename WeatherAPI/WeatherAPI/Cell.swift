//
//  Cell.swift
//  WeatherAPI
//
//  Created by Oliver Zheng on 6/27/23.
//

import SwiftUI

struct Cell: View {
    let obj: Response
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text(obj.name)
                    Text(getTime())
                }
                .padding()
                Spacer()
                Text("\(String(format: "%.2f", obj.main.temp))°")
                    .padding()
                }
            Spacer()
            HStack{
                HStack{
                    Text(obj.weather[0].description)
                    AsyncImage(url: URL(string: "\("https://openweathermap.org/img/wn/\(obj.weather[0].icon)@2x.png")")){ image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                    } placeholder: {
                        Image(systemName:"cloud.sun")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                    }
                }
                .padding(.leading)
                Spacer()
                HStack{
                    Text("L: \(String(format: "%.2f", obj.main.temp_min))°")
                    Text("H: \(String(format: "%.2f", obj.main.temp_max))°")
                    
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
        }
    }
    private func getTime() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: obj.timezone)
        let currentDate = Date()
        return dateFormatter.string(from: currentDate)
    }
}

//struct Cell_Previews: PreviewProvider {
//    static var previews: some View {
//        Cell()
//    }
//}
