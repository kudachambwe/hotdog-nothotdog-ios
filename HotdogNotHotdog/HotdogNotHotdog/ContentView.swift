//
//  ContentView.swift
//  HotdogNotHotdog
//
//  Created by Kudakwashe Chambwe on 08/10/2019.
//  Copyright © 2019 Bouvet Norge AS. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cameraState: CameraState
    
    var body: some View {
        ZStack {
            ImageView(cameraState: cameraState)
            
            ResultView(cameraState: cameraState)
            
            if cameraState.isTakingPhoto {
                CameraView(cameraState: cameraState)
                    .transition(AnyTransition.move(edge: .trailing))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(cameraState: CameraState())
    }
}
