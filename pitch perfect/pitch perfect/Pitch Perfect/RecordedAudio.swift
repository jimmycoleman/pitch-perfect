//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by jimmy on 09/04/2015.
//  Copyright (c) 2015 udacityNano. All rights reserved.
//

import Foundation


class RecordedAudio: NSObject {
    let filePathUrl : NSURL!
    let title: String!
    
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl;
        self.title = title;
    }
}