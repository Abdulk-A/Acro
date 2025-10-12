//
//  SlidingDoorView.swift
//  Acro
//
//  Created by Abdullah on 10/11/25.
//

import SwiftUI

//struct SlidingDoorView: View {
//    
//    @State private var isOpen = true
//    let height: CGFloat?
//    
//    var body: some View {
//        ZStack {
//            HStack {
//
//            }
//
//         
//            HStack {
//                //Future conent here perhaps
//            }
//                .frame(width: UIScreen.main.bounds.width, height: height ?? 75.0)
//                .background(.regularMaterial)
//                .padding(.vertical)
//                .animation(.easeInOut(duration: 0.5), value: isOpen)
//                .offset(x: isOpen ? UIScreen.main.bounds.width * 2 : 0)
//        }
//    }
//}
//
//#Preview {
//    SlidingDoorView(height: nil)
//}


struct SlidingDoorView<Content: View>: View {
    
    
    @Binding var isOpen: Bool
    let height: CGFloat?
    let content: () -> Content
    
    init(_ isOpen: Binding<Bool>, _ height: CGFloat? = nil, @ViewBuilder content: @escaping () -> Content) {
        self._isOpen = isOpen
        self.content = content
        self.height = height
    }
    

    
    var body: some View {
        ZStack {
            if isOpen {
                HStack {
                    content()
                }
                .frame(width: UIScreen.main.bounds.width / 1.2, height: height ?? 75.0)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.regularMaterial)
                )
                .padding(.vertical)
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing),
                    removal: .move(edge: .trailing)
                ))
                
            }
        }
        .animation(.easeInOut(duration: 0.5), value: isOpen)
        .zIndex(1) 
    }
}
