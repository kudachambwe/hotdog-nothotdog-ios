//
//  CameraState.swift
//  HotdogNotHotdog
//
//  Created by Kudakwashe Chambwe on 08/10/2019.
//  Copyright © 2019 Bouvet Norge AS. All rights reserved.
//

import SwiftUI
import Combine

class CameraState: ObservableObject {
    
    // Tells views that the object has changed.
    var objectWillChange = ObservableObjectPublisher()
    
    // Notifies views that object is changing.
    var isTakingPhoto = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    var hotDogPhoto: UIImage? = nil {
        willSet {
            objectWillChange.send()
        }
    }
    
    
}
