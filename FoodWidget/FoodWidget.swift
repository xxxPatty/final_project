//
//  FoodWidget.swift
//  FoodWidget
//
//  Created by 林湘羚 on 2021/1/6.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        //let restaurant = restaurantInfo(restaurantName: "test", restaurantType:"test", time: Date(), done: false, reflections:"", scores: 0, addr:"", position: Position(lat: 0, lng: 0))
        //SimpleEntry(date: Date(), configuration: ConfigurationIntent(), restaurant: restaurant)
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), restaurantName:"t")
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, restaurantName:"tt")
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        var restaurantName = ""
        let userDefaults = UserDefaults(suiteName: "group.Patty")
        if let messages = userDefaults?.string(forKey: "last") {
            restaurantName = messages
        }

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for secondOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .second, value: secondOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, restaurantName: restaurantName)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let restaurantName: String
}

struct FoodWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack{
            Color(red:231/255, green:216/255, blue:201/255).edgesIgnoringSafeArea(.all)
            Text(entry.restaurantName)
                //.foregroundColor(.white)
                .fontWeight(.bold)
                //.font(.largeTitle)
        }
    }
}

@main
struct FoodWidget: Widget {
    let kind: String = "FoodWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            FoodWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct FoodWidget_Previews: PreviewProvider {
    static var previews: some View {
        FoodWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), restaurantName: "test"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
