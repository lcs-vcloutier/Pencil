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
            DrawingView(canvas: $canvas, isDraw: $isDraw)
                .navigationTitle("Drawing")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button(action: {
                    
                    // saving Image...
                    
                    
                }, label: {
                    
                    Image(systemName: "square.and.arrow.down.fill")
                        .font(.title)
                }),trailing: HStack(spacing: 15){
                    
                    Button(action: {
                        
                        // Erase tool
                        
                        isDraw.toggle()
                        
                    }) {
                        
                        Image(systemName: "pencil.slash")
                            .font(.title)
                    }
                    
                                       // Menu For InkType And Color....
                                       
                                       Menu {
                                           
                                           // Color Picker...
                                           
                                           Button(action: {
                                               
                                               colorPicker.toggle()
                                               
                                           }) {
                                               
                                               Label {
                                                   
                                                   Text("Color")
                                                   
                                               } icon: {
                                                   
                                                   Image(systemName: "eyedropper.full")
                                               }
                                           }
                                           
                                           Button(action: {
                                               
                                               // changing type....
                                               
                                               isDraw = true
                                               type = .pencil
                                               
                                           }) {
                                               
                                               Label {
                                                   
                                                   Text("Pencil")
                                                   
                                               } icon: {
                                                   
                                                   Image(systemName: "pencil")
                                               }
                                               
                                           }
                                           
                                           Button(action: {
                                               
                                               isDraw = true
                                               type = .pen
                                               
                                           }) {
                                               
                                               Label {
                                                   
                                                   Text("Pen")
                                                   
                                               } icon: {
                                                   
                                                   Image(systemName: "pencil.tip")
                                               }
                                               
                                           }
                                           
                                           Button(action: {
                                               
                                               isDraw = true
                                               type = .marker
                                               
                                           }) {
                                               
                                               Label {
                                                   
                                                   Text("Marker")
                                                   
                                               } icon: {
                                                   
                                                   Image(systemName: "highlighter")
                                               }
                                               
                                           }
                                           
                                       } label: {
                                           
                                           Image("menu")
                                               .resizable()
                                               .frame(width: 22, height: 22)
                                       }

                                   })
                                   .sheet(isPresented: $colorPicker) {
                                       
                                       ColorPicker("Pick Color", selection: $color)
                                           .padding()
                                   }
                           }
                       }
    
struct DrawingView : UIViewRepresentable {
    
    // To capture drawing for saving into albums
    @Binding var canvas : PKCanvasView
    @Binding var isDraw : Bool
    
    let ink = PKInkingTool(.pencil, color: .black)
    let eraser = PKEraserTool(.bitmap)
    
    func makeUIView(context: Context) -> PKCanvasView{
        
        canvas.drawingPolicy = .anyInput
        canvas.tool = isDraw ? ink : eraser
        
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
        // updating tool when ever main view updates
        uiView.tool = isDraw ? ink : eraser
    }
}
