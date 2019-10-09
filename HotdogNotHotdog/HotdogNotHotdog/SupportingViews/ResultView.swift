//
//  ResultView.swift
//  HotdogNotHotdog
//
//  Created by Kudakwashe Chambwe on 09/10/2019.
//  Copyright © 2019 Bouvet Norge AS. All rights reserved.
//

import SwiftUI

struct ResultView: View {
      @ObservedObject var cameraState: CameraState
    
    
    var body: some View {
        VStack {
            if cameraState.showResult {
                if cameraState.isHotDog {
                    Image("Hotdog")
                    .resizable()
                    .frame(width: 150, height: 150)
                     .transition(AnyTransition.move(edge: .top))
                } else {
                    Image("Not-Hotdog")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .transition(AnyTransition.move(edge: .top))
                }
            }
            Spacer()
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        let cameraState = CameraState()
        cameraState.showResult = false
        return ResultView(cameraState: cameraState)
    }
}
