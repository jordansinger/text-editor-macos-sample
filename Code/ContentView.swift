//
//  ContentView.swift
//  Code
//
//  Created by Jordan Singer on 9/6/20.
//

import SwiftUI

struct FileItem: Hashable, Identifiable {
    var id: Self { self }
    var name: String
    var image: String
    var children: [FileItem]? = nil
    var selected: Bool = false
}

let data =
    FileItem(name: "Code", image: "folder", children:
    [
        FileItem(name: "assets", image: "folder", children: []),
        FileItem(name: "index.html", image: "doc", selected: true),
        FileItem(name: "style.css", image: "doc"),
    ])

struct ContentView: View {
    @State var selection: Set<Int> = [0]
    
    var body: some View {
        NavigationView {
            List(selection: self.$selection) {
                Section(header: Text("Folders")) {
                    OutlineGroup(data, children: \.children) { item in
                        if item.selected {
                            Label(item.name, systemImage: item.image)
                            .tag(0)
                        } else {
                            Label(item.name, systemImage: item.image)
                        }
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 180, idealWidth: 180, maxWidth: 180, maxHeight: .infinity)
            
            CodeView()
        }
    }
}

struct CodeView: View {
    @State var text = ""
    
    var body: some View {
        ZStack {
            // demo syntax highlighting
//            HStack {
//                VStack(alignment: .leading, spacing: 4) {
//                    Group {
//                        Text("<!").foregroundColor(.gray) + Text("DOCTYPE").foregroundColor(.purple) + Text(" html").foregroundColor(.orange) + Text(">").foregroundColor(.gray)
//                    }
//
//                    Group {
//                        Text("<").foregroundColor(.gray) + Text("html").foregroundColor(.red) + Text(">").foregroundColor(.gray)
//                        Text("<").foregroundColor(.gray) + Text("head").foregroundColor(.red) + Text(">").foregroundColor(.gray)
//                    }
//
//                    HStack(spacing: 0) {
//                        Group {
//                            Text("    <").foregroundColor(.gray) + Text("title").foregroundColor(.red) + Text(">").foregroundColor(.gray)
//                        }
//                        Group {
//                            Text("</").foregroundColor(.gray) + Text("title").foregroundColor(.red) + Text(">").foregroundColor(.gray)
//                        }
//                    }
//
//                    Group {
//                        Text("</").foregroundColor(.gray) + Text("head").foregroundColor(.red) + Text(">").foregroundColor(.gray)
//                        Text("<").foregroundColor(.gray) + Text("body").foregroundColor(.red) + Text(">").foregroundColor(.gray)
//                        Text("")
//                        Text("</").foregroundColor(.gray) + Text("body").foregroundColor(.red) + Text(">").foregroundColor(.gray)
//                        Text("</").foregroundColor(.gray) + Text("html").foregroundColor(.red) + Text(">").foregroundColor(.gray)
//                    }
//                    Spacer()
//                }
//                Spacer()
//            }
//            .padding(8)
//            .font(.system(.body, design: .monospaced))
            
            TextEditor(text: $text)
                .padding(8)
                .font(.system(.body, design: .monospaced))
        }
        .background(Color(NSColor.textBackgroundColor))
        .toolbar {
            ToolbarItem(placement: .status) {
                Button(action: { }) {
                    Image(systemName: "plus")
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
