//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Gil Ferreira on 5/27/15.
//  Copyright (c) 2015 Gil Ferreira. All rights reserved.
//

import Foundation
import AVFoundation

class RecordedAudio: NSObject {
    
    var filePathUrl : NSURL!
    var title: String!
    
    init(recorder: AVAudioRecorder){
        
        filePathUrl = recorder.url
        title = recorder.url.lastPathComponent
        
    }
    
}