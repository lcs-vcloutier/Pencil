//
//  ContentView.swift
//  Pencil
//
//  Created by Cloutier, Vincent on 2020-11-02.
//

import SwiftUI
import PencilKit


struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct Home : View {
    
    @State var canvas = PKCanvasView()
    @State var isDraw = true
    @State var color : Color = .black
    @State var type : PKInkingTool.InkType = .pencil
    @State var colorPicker = false
    
    // Default is pen
     
    var body: some View{
        
        NavigationView{
            
            // Drawing View
            DrawingView(canvas: $canvas)
                .navigationTitle("Drawing")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
struct DrawingView : UIViewRepresentable {
    
    // To capture drawing for saving into albums
    @Binding var canvas : PKCanvasView
    
    func makeUIView(context: Context) -> PKCanvasView{
        
        canvas.drawingPolicy = .anyInput
        
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
        
    }
}
