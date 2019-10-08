//
//  ImageView.swift
//  HotdogNotHotdog
//
//  Created by Kudakwashe Chambwe on 08/10/2019.
//  Copyright © 2019 Bouvet Norge AS. All rights reserved.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var cameraState: CameraState
    
    var body: some View {
        ZStack {
            // Takes the first photo in ImagePicker into ImageView.
            cameraState.hotDogPhoto.map({ hotdogPhoto in
                Image(uiImage: hotdogPhoto)
                .resizable()
                .aspectRatio(contentMode: .fit)
            })
            
            VStack {
                Spacer()
                Button(action: {
                    self.cameraState.isTakingPhoto = true
                }) {
                    Text("Take photo")
                    .padding()
                    .background(Color.orange)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                }
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(cameraState: CameraState())
    }
}
