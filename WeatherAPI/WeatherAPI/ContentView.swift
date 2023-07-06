//
//  ContentView.swift
//  WeatherAPI
//
//  Created by Oliver Zheng on 6/25/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel =  WeatherServiceModel()
    @State var searchText = "San Jose"
       
    var body: some View {

        
        NavigationStack {
            ZStack {
                BackGround()
                VStack {

                        ForEach(viewModel.responses, id: \.self ){ obj in
                                Cell(obj: obj)
                               
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 180)
                            .background(.ultraThinMaterial)
                            .colorScheme(.dark)
                            .cornerRadius(15)
                            .padding(.horizontal)
                        Spacer()
                        }
                        .navigationTitle("Weather")
                        .onAppear{

    
                        
                            viewModel.getAsycAwait(searchText: searchText)
                        }
                        
                    }
            .searchable(text: $searchText, prompt: "Search for a city/state in USA")
            .onSubmit(of: .search) {
               
                
                
                viewModel.getAsycAwait(searchText: searchText)
            }
                }
            
        }
    private var searchBar: some View {
        TextField("Search for a cty/state in USA", text: $searchText)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(15)
            .padding(.horizontal, 16)
    }
    private func getDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let currentTime = formatter.string(from: date)
        return currentTime
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
