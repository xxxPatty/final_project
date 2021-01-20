//
//  RestaurantEditorView.swift
//  final_project3
//
//  Created by 林湘羚 on 2021/1/3.
//

import SwiftUI

struct restaurantEditor:View{
    @State private var MyMapItems:MapItems=MapItems()
    @State private var restaurantName=""
    @State private var restaurantType=""
    @State private var restaurantTypeIndex=0
    @State private var time=Date()
    @State private var done=false
    @State private var reflections="食記"
    @State private var scores=6.0
    @State private var addr="地址"
    @State private var position=Position(lat:-1, lng:-1)
    @State private var selectImage = Image(systemName: "photo")
    @State private var showSelectPhoto = false
    //@State private var selectUIImage = Image(systemName: "photo").asUIImage()
    @State private var isSharePresented: Bool = false   //分享shheet
    @Environment(\.presentationMode) var presentationMode
    var restaurantdata:restaurantInfoData
    var editRestaurantIndex:Int?
    let someRestaurantTypes=["咖啡廳", "早午餐店", "早餐店", "小吃", "餐酒館", "速食店", "義式餐廳", "日式餐廳", "港式餐廳", "美式餐廳", "其他"]
    init(restaurantdata:restaurantInfoData, editRestaurantIndex:Int?=nil){
        self.restaurantdata=restaurantdata
        self.editRestaurantIndex=editRestaurantIndex
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View{
        Form{
            HStack{
                //要上傳的照片
                Button(action: {
                    showSelectPhoto = true
                }){
                    selectImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                }
                .buttonStyle(PlainButtonStyle())
                .sheet(isPresented: $showSelectPhoto) {
                    ImagePickerController(showSelectPhoto: self.$showSelectPhoto, selectImage: $selectImage)
                }
                Spacer()
                //分享鍵
                Button(action:{
                    //selectUIImage = selectImage.asUIImage()
                    self.isSharePresented = true
                }) {
                    Image(systemName: "square.and.arrow.up")
                }
                .sheet(isPresented: $isSharePresented, onDismiss: {
                    print("Dismiss")
                }, content: {
                    ActivityViewController(activityItems: [loadImageFromDocumentDirectory(nameOfImage: restaurantName), restaurantName, reflections, scores, addr])
                })
            }
            
            TextField("店名", text:$restaurantName)
            Picker(selection: $restaurantTypeIndex, label: Text("類型"), content: {
                ForEach(someRestaurantTypes.indices){(index) in
                    Text("\(someRestaurantTypes[index])")
                }
            })
            DatePicker("日期", selection: $time, displayedComponents:.date)
            Toggle("已吃", isOn: $done)
                .toggleStyle(SwitchToggleStyle(tint: Color(red:230/255, green:190/255, blue:174/255)))
            TextEditor(text: $reflections)
                .disabled(!done)
                .frame(height:200)
            Stepper("分數\(scores, specifier:"%.1f")", value:$scores, in: 0...10, step:0.5)
                .disabled(!done)
            TextEditor(text: $addr)
                .disabled(!done)
                .frame(height:200)
            
        }
            .background(Color(red:231/255, green:216/255, blue:201/255))
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Add new restaurant")
            .accentColor(Color.pink)
            .toolbar(content: {
                ToolbarItem{
                    
                
                    Button(action: {
                        //先透過google maps api將地址轉成經緯度
                        if addr != "地址" && !addr.isEmpty{
                            let urlStr = "https://maps.googleapis.com/maps/api/geocode/json?address=\(addr) E-Square&key=AIzaSyBPVZM0o_QRqGYkCYjbWHl0Z8q0wxTGi1Y".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                            if let url = URL(string: urlStr!) {
                                URLSession.shared.dataTask(with: url) { (data, response , error) in
                                    let decoder = JSONDecoder()
                                    if let data = data {
                                        do {
                                            MyMapItems = try decoder.decode(MapItems.self, from: data)
                                        } catch {
                                            print(error)
                                        }
                                    } else {
                                        print("error")
                                    }
                                    position=Position(lat:MyMapItems.results[0].geometry.location.lat, lng:MyMapItems.results[0].geometry.location.lng)
                                    //再將所有資訊（含經緯度）存起來
                                    if let editRestaurantIndex=editRestaurantIndex{
                                        restaurantdata.myrestaurantInfo[editRestaurantIndex]=restaurantInfo(restaurantName: restaurantName, restaurantType: someRestaurantTypes[restaurantTypeIndex], time: time, done: done, reflections: reflections, scores: scores, addr: addr, position: position)
                                    }else{
                                        restaurantdata.myrestaurantInfo.insert(restaurantInfo(restaurantName: restaurantName, restaurantType: someRestaurantTypes[restaurantTypeIndex], time: time, done: done, reflections: reflections, scores: scores, addr: addr, position: position), at:0)
                                    }
//                                    presentationMode.wrappedValue.dismiss()
                                }.resume()
                            }
                        }
                        //將照片存進document directory
                        
                        saveImageToDocumentDirectory(image: selectImage.asUIImage(), fileName: restaurantName)
                        presentationMode.wrappedValue.dismiss()
                        //將餐廳data存到userDefaults中
                        let userDefaults = UserDefaults(suiteName: "group.Patty")
                        userDefaults?.set(restaurantName, forKey: "last")
                    }, label: {
                        Text("Save")
                            .foregroundColor(Color.pink)
                    })
                }
            })
        
        .onAppear(perform:{
            
            if let editRestaurantIndex=editRestaurantIndex{

                let editRestaurant=restaurantdata.myrestaurantInfo[editRestaurantIndex]

                restaurantName=editRestaurant.restaurantName
                restaurantType=editRestaurant.restaurantType
                time=editRestaurant.time
                done=editRestaurant.done
                reflections=editRestaurant.reflections=="" ? "食記" : editRestaurant.reflections
                scores=editRestaurant.scores
                addr=editRestaurant.addr
                position=editRestaurant.position
                
                selectImage=Image(uiImage: loadImageFromDocumentDirectory(nameOfImage: restaurantName))
                
                if restaurantTypeIndex == 0 {
                    for i in 0...someRestaurantTypes.count-1{
                        if editRestaurant.restaurantType==someRestaurantTypes[i]{
                            restaurantTypeIndex=i
                        }
                    }
                }
            }
        })
        .navigationBarTitle(editRestaurantIndex == nil ? "Add new restaurant" : "Edit restaurant")
    }
}

