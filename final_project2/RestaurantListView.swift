//
//  Restaurant.swift
//  final_project3
//
//  Created by 林湘羚 on 2021/1/3.
//

import SwiftUI

struct Position:Codable{
    var lat:Double
    var lng:Double
}

struct restaurantInfo:Identifiable, Codable{
    var id=UUID()
    var restaurantName:String
    var restaurantType:String
    var time:Date
    var done:Bool=false
    var reflections:String
    var scores:Double
    var addr:String
    var position:Position
}
class restaurantInfoData:ObservableObject{
    @AppStorage("restaurantInfo") var restaurantInfoData:Data?
    @Published var myrestaurantInfo=[restaurantInfo](){
        didSet{ //property observer
            let encoder=JSONEncoder()
            do{
                let data=try encoder.encode(myrestaurantInfo)
                restaurantInfoData=data
            }catch{
                
            }
        }
    }
    init(){
        if let restaurantInfoData=restaurantInfoData{
            let decoder=JSONDecoder()
            if let decodedData=try? decoder.decode([restaurantInfo].self, from: restaurantInfoData){
                myrestaurantInfo=decodedData
            }
        }
    }
}
struct restaurantRow:View{
    var restaurant:restaurantInfo
    var body: some View{
        HStack{
            Text(restaurant.restaurantName)
            Spacer()
            Text((restaurant.scores>=8) ? "推" : "不推")
            Image(systemName: (restaurant.scores>=8) ? "hand.thumbsup.fill" : "hand.thumbsdown.fill")
        }
    }
}
struct restaurantList:View{
    @ObservedObject var restaurantData=restaurantInfoData()
    @State private var showRestaurantEditor=false
    @State private var searchBarText:String=String()
    var filterWords: [restaurantInfo] {
            return restaurantData.myrestaurantInfo.filter({searchBarText.isEmpty ? true : $0.restaurantName.contains(searchBarText)})
           }
    init(restaurantData:restaurantInfoData){
        self.restaurantData=restaurantData
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    func fundIdx(restaurant:restaurantInfo) -> Int {
            for idx in 0...restaurantData.myrestaurantInfo.count-1 {
                if restaurant.id == restaurantData.myrestaurantInfo[idx].id{
                    return idx
                }
            }
            return -1
        }
    var body: some View{
        NavigationView{
            VStack{
                SearchBarView(searchBarText: $searchBarText)
                List{
                    ForEach(filterWords){(index) in
                        NavigationLink(destination:restaurantEditor(restaurantdata: restaurantData, editRestaurantIndex:fundIdx(restaurant: index))){
                            restaurantRow(restaurant:index)
                        }
                        .listRowBackground(Color(red:238/255, green:228/255, blue:225/255))
                    }
                    .onDelete{(indexSet) in
                        restaurantData.myrestaurantInfo.remove(atOffsets: indexSet)
                    }
                    .onMove{(indexSet, index) in
                        restaurantData.myrestaurantInfo.move(fromOffsets: indexSet, toOffset: index)
                    }
                }
                .background(Color(red:231/255, green:216/255, blue:201/255))
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitle("口袋名單")
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action:{
                            showRestaurantEditor=true
                        }, label:{
                            Image(systemName: "plus.circle.fill")
                        })
                    }
                    ToolbarItem(placement:.navigationBarLeading){
                        EditButton()
                    }
                })
                .sheet(isPresented: $showRestaurantEditor){
                    NavigationView{
                        restaurantEditor(restaurantdata:restaurantData)
                    }
                }
            }
        }
    }
}

struct restaurantLIstView_Previews: PreviewProvider {
    static var previews: some View {
        restaurantList(restaurantData:restaurantInfoData())
    }
}
