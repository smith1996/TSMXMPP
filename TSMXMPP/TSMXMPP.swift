//
//  TSMXMPP.swift
//  TSMXMPP
//
//  Created by Smith Huamani on 9/04/18.
//  Copyright © 2018 Smith Huamani. All rights reserved.
//

import Foundation
import XMPPFramework

open class TSMXMPP {
    
    private var stream: XMPPStream!

    public init(domain: String) {
        stream = XMPPStream()
        stream.myJID = XMPPJID(user: "smith", domain: domain, resource: "mobile")
    }
    
    open var getFullNameJID: String {
        return stream.myJID!.full
    }
    
}
