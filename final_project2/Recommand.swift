//
//  Recommand.swift
//  final_project2
//
//  Created by 林湘羚 on 2021/1/5.
//

import SwiftUI

struct RocommandView: View{
    @State private var Rocommandrestaurants:[restaurantInfo]=[]
    @State private var idx:Int=0
    @ObservedObject var restaurantData=restaurantInfoData()
    @State private var selectImage = Image(systemName: "photo")
    @State private var reflections=""
    @State private var scale=1
    @GestureState var isDetectingLongPress = false
    
    var body: some View{
        let press = LongPressGesture(minimumDuration: 0.5)
            .sequenced(before: LongPressGesture(minimumDuration: .infinity))
            .updating($isDetectingLongPress) { value, state, transaction in
                switch value {
                case .second(true, nil): //This means the first Gesture completed
                    state = true
                default: break
                }
            }
        ZStack{
            EmitterLayerView()
            VStack{
                Button(action:{
                                Rocommandrestaurants=[]
                                for index in 0 ... restaurantData.myrestaurantInfo.count-1 {
                                    if restaurantData.myrestaurantInfo[index].scores >= 8 {
                                        Rocommandrestaurants.append(restaurantData.myrestaurantInfo[index])
                                    }
                                }
                                idx = Int.random(in: 0 ..< Rocommandrestaurants.count)
                                selectImage=Image(uiImage: loadImageFromDocumentDirectory(nameOfImage: Rocommandrestaurants[idx].restaurantName))
                                reflections = Rocommandrestaurants[idx].reflections
                            }){
                                Text("推薦")
                            }
                            selectImage
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 200)
                                .clipped()
                                .gesture(press)
                                .scaleEffect(isDetectingLongPress ? 2 : 1)
                            TextEditor(text: $reflections)
                                .frame(height:200)
                                .background(Color.pink)
                                .foregroundColor(.black)
                                .opacity(0.95)
                                .padding()
            }
        }
        .background(Color(red:231/255, green:216/255, blue:201/255))
    }
}

struct Recommand_Previews: PreviewProvider {
    static var previews: some View {
        RocommandView()
    }
}
