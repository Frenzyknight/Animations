//
//  ContentView.swift
//  Animations
//
//  Created by Gaurav Ganju on 25/02/22.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading),
                  identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    @State private var animationAmount = 1.0
    @State private var rotationAmount = 0.0
    let letters = Array("Hello, SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    var body: some View {
        VStack {
            Spacer()
            Button("Tap Me") {
                withAnimation(.interpolatingSpring(stiffness: 10, damping: 3)) {
                    rotationAmount += 360
                }
            }
            .padding(50)
            .background(.orange)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(.degrees(rotationAmount), axis: (x:0.5, y:1, z:0.5))
            Spacer()
            Button("Tap Me") {
               // animationAmount += 1
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(.red)
                    .scaleEffect(animationAmount)
                    .opacity(2 - animationAmount)
                    .animation(
                        .easeInOut(duration: 1)
                        .repeatForever(autoreverses: false),
                        value: animationAmount
                    )
            )
            .onAppear {
                animationAmount = 2
            }
            Spacer()
            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
                .padding()
            Spacer()
            Button("Tap me") {
                animationAmount += 1
            }
            .padding(50)
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
            
            Spacer()
            
        }
//        HStack (spacing: 0) {
//            ForEach(0..<letters.count) { num in
//                Text(String(letters[num]))
//                    .padding(5)
//                    .font(.title)
//                    .background(enabled ? .blue : .red)
//                    .offset(dragAmount)
//                    .animation(
//                        .default.delay(Double(num) / 20),
//                        value: dragAmount)
//                    .gesture(
//                        DragGesture()
//                            .onChanged { dragAmount = $0.translation }
//                            .onEnded { _ in
//                                dragAmount = .zero
//                                enabled.toggle()
//                            }
//                    )
//
//
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
