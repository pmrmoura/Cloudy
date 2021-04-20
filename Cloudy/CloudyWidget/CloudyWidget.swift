//
//  CloudyWidget.swift
//  CloudyWidget
//
//  Created by Juliano Vaz on 20/04/21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct CloudyWidgetEntryView : View {
    
    var textShown: Bool = false
    var entry: Provider.Entry

    var body: some View {
        //        Text(entry.date, style: .time)
        
        GeometryReader { geometry in
       
            VStack (alignment: .leading){
                Spacer()
                
                if(self.textShown) {
                
                Text("Olá, Claudinha")
                    .font(.body)
                    .fontWeight(.bold)
                    .padding(.bottom, 4)
                
                Text("Que tal tirar um tempinho para descansar?")
                    .font(.caption)
//                Text("Aproveite para praticar agora.")
//                    .font(.caption)
                }
                else {
            
                Text("Faça uma pausa")
                    .font(.body)
                    .fontWeight(.bold)
                    .padding(.bottom, 4)
                
                Text("Meditar ajuda a diminuir o stress e a ansiedade.")
                    .font(.caption)
                Text("Aproveite para praticar agora.")
                    .font(.caption)
                }
                
                Spacer()
            
            }
            .font(.title)
            .foregroundColor(.black)
            .frame(width: geometry.size.width, height:  geometry.size.height)
//            .onTapGesture {
//                self.muda()
//            }
      
   
        } .background(Image("backgroundWidget").resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/))
        
    }
    
//     func muda() {
//        self.textShown.toggle()
//    }
}

@main
struct CloudyWidget: Widget {
    let kind: String = "CloudyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CloudyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Lembre-se de pausar")
        .description("Que tal tirar um tempinho para descansar?")
        .supportedFamilies([.systemMedium])
    }
}

struct CloudyWidget_Previews: PreviewProvider {
    static var previews: some View {
        CloudyWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
