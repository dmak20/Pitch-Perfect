//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Dan Makfinsky on 3/8/15.
//  Copyright (c) 2015 Faktory Studios LLC. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathUrl: NSURL!
    var title: String!
    
    init(title: String!, filePathUrl: NSURL!) {
        
        self.title = title
        self.filePathUrl = filePathUrl
        
    }
}