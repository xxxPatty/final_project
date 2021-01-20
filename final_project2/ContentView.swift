//
//  ContentView.swift
//  final_project2
//
//  Created by 林湘羚 on 2021/1/1.
//

import SwiftUI

struct ContentView: View {
    @StateObject var restaurantData=restaurantInfoData()
    
    var body: some View {
        TabView{
            SearchFood()
                .tabItem{
                    Image(systemName:"magnifyingglass")
                    Text("Search")
                }
            restaurantList(restaurantData:restaurantData)
                .tabItem{
                    Image(systemName:"pencil")
                    Text("Records")
                }
            MapView2(restaurantData:restaurantData)
                .tabItem{
                    Image(systemName:"mappin.and.ellipse")
                    Text("Map")
                }
            RocommandView(restaurantData:restaurantData)
                .tabItem{
                    Image(systemName:"heart")
                    Text("For you")
                }
        }.accentColor(Color.pink)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
