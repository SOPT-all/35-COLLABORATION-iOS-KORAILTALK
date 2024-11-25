//
//  UIView+Preview.swift
//  35-Seminar
//
//  Created by 조호근 on 11/19/24.
//

#if DEBUG
import SwiftUI

extension UIView {
    
    private struct Preview: UIViewRepresentable {
        let view: UIView
        
        func makeUIView(context: Context) -> some UIView {
            return view
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) { }
    }
    
    func toPreview() -> some View {
        Preview(view: self)
    }
    
}
#endif
