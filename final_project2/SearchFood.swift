//
//  SearchFood.swift
//  final_project2
//
//  Created by 林湘羚 on 2021/1/1.
//

import SwiftUI

struct SearchFood:View{
    @State private var MyFoodItems:FoodItems=FoodItems()
    @State private var city:String=""
    @State private var selectedIndex:Int=0
    @State private var timeRange:[String]=["月", "週"]
    var body: some View{
        NavigationView{
            ZStack{
                Color(red:231/255, green:216/255, blue:201/255)
                VStack{
                    HStack{
                        Picker(selection: $selectedIndex, label: Text("")) {
                            Text("月").tag(0)
                            Text("週").tag(1)
                         }
                        .frame(width:50, height:50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black)
                        )
                        .clipped()
                        TextField("enter city", text: $city)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                        Button("搜尋"){
                            let urlStr = "https://www.googleapis.com/customsearch/v1?cx=49ea75e339e740b13&key=AIzaSyAmvRNAu83MEI8q4S0HcOTyr3lQZfJ8z7o&q=\(city)美食\(timeRange[selectedIndex])排行榜&siteSearch=ifoodie.tw".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                            if let url = URL(string: urlStr!) {
                                URLSession.shared.dataTask(with: url) { (data, response , error) in
                                    let decoder = JSONDecoder()
                                    //decoder.dateDecodingStrategy = .iso8601
                                    if let data = data {
                                        do {
                                            MyFoodItems = try decoder.decode(FoodItems.self, from: data)
                                        } catch {
                                            print(error)
                                        }
                                    } else {
                                        print("error")
                                    }
                                }.resume()
                            }

                        }
                    }
                    .fixedSize()
                    if(MyFoodItems.items.count==0){
                        LottieView(fileName:"empty")
                            .frame(width:250, height:250, alignment: .center)
                            .navigationTitle("Find Restaurant")
                    }else{
                        List{
                            ForEach(MyFoodItems.items.indices, id: \.self){ (index) in
                                NavigationLink(destination: FoodDetailView(og_description: MyFoodItems.items[index].pagemap.metatags[0].og_description, link:MyFoodItems.items[index].link)){
                                    HStack{
                                        NetworkImage(urlString: MyFoodItems.items[index].pagemap.cse_thumbnail[0].src)
                                            .frame(height:100)
                                        Text(MyFoodItems.items[index].title)
                                    }
                                }
                            }
                        }
                        .navigationTitle("Find Restaurant")
                    }
                }
            }
        }
    }
}


