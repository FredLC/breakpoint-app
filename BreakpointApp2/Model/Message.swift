//
//  Message.swift
//  BreakpointApp2
//
//  Created by Fred Lefevre on 2019-12-17.
//  Copyright © 2019 Fred Lefevre. All rights reserved.
//

import Foundation

class Message {
    private var _content: String
    private var _senderId: String
    
    var content: String {
        return _content
    }
    
    var senderId: String {
        return _senderId
    }
    
    init(content: String, senderId: String) {
        self._content = content
        self._senderId = senderId
    }
}
