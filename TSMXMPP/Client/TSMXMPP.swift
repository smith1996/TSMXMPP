//
//  TSMXMPP.swift
//  TSMXMPP
//
//  Created by Smith Huamani on 9/04/18.
//  Copyright © 2018 Smith Huamani. All rights reserved.
//

import Foundation
import XMPPFramework

protocol TSMXMPPIncomingMessageDelegate {
    func receivedMessage(message: Message)
}

protocol TSMXMPPOutgoingMessageDelegate {
    func willSendMessage(message: Message)
    func willReceiveSendMessage(message: Message)
    func didFailToSendMessage(error: Error)
}

typealias TSMXMPPcompletionHandler = () -> Void

open class TSMXMPP: TSMXMPPClientDelegate {
    
//    public init(domain: String) {
//        stream = XMPPStream()
//        stream.myJID = XMPPJID(user: "smith", domain: domain, resource: "mobile")
//    }
    
//    open var getFullNameJID: String {
//        return stream.myJID!.full
//    }
    
//    private var hostName = "192.168.1.238"

    private var hostDomain = ""
    private var resource = ""
    
    var xmppStream: XMPPStream!
    private var xmppRoster: XMPPRoster!
    private var xmppRosterStorage: XMPPRosterMemoryStorage!
    
    var passwordJID: String!
    var isAutoReconnecting: Bool!
    
    var xmppIncomingMessageDelegate: TSMXMPPIncomingMessageDelegate!
    var xmppOutgoingMessageDelegate: TSMXMPPOutgoingMessageDelegate!
    
    
    public init(domain: String) {
        
        xmppStream = XMPPStream()
        xmppStream.hostName = "192.168.1.238"
        xmppStream.hostPort = 5222
        xmppStream.startTLSPolicy = .allowed
        hostDomain = domain
        resource = "mobile"
        
        xmppRosterStorage = XMPPRosterMemoryStorage()
        xmppRoster = XMPPRoster(rosterStorage: xmppRosterStorage)
        xmppRoster.autoFetchRoster = true
        
        xmppStream.addDelegate(self, delegateQueue: DispatchQueue.main)
        //        DDLog.add(DDTTYLogger.sharedInstance, with: .all)
    }
    
    public func disconnect() {
        
        self.isAutoReconnecting = false
        
        var _ = XMPPPresence(type: "unavailable")
        xmppStream.disconnect()
    }
    
    private func getDateCurrent(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    
    public func login(username: String, password: String) {
        
        guard username != "" else {
            print("Ingresar las credenciales USERNAME")
            return
        }
        
        guard password != "" else {
            print("Ingresar las credenciales PASSWORD")
            return
        }
        
        do {
            if !xmppStream.isConnected {
                try! xmppStream.connect(withTimeout: XMPPStreamTimeoutNone)
            }
            
            if !xmppStream.isAuthenticated {
                xmppStream.myJID = XMPPJID(string: username + "@" + hostDomain, resource: resource)
                passwordJID = password
            }
        } catch let error as NSError {
            print("Error connecting 😡😡😡: " + error.debugDescription)
        }
        
    }
    
    public func login(username: String) {
        
        guard username != "" else {
            print("Ingresar las credenciales USERNAME")
            return
        }
        
        do {
            if !xmppStream.isConnected {
                try! xmppStream.connect(withTimeout: XMPPStreamTimeoutNone)
            }
            if !xmppStream.isAuthenticated {
                xmppStream.myJID = XMPPJID(string: username + "@" + hostDomain, resource: resource)
                passwordJID = "12345678"
            }
            
        } catch let error as NSError {
            print("Error connecting 😡😡😡: " + error.debugDescription)
        }
    }
    
    public func autoReconnect(isAutoreconnecting: Bool) {
        self.isAutoReconnecting = isAutoreconnecting
    }
    
    public func sendMessage(sendTo: String, message: String) {
        
        guard sendTo != "" else {
            print("Ingresar el destinatario")
            return
        }
        
        guard message != "" else {
            print("Ingresar el mensaje")
            return
        }
        
        if isAutoReconnecting {
            
            let messageResponse = TSMMessage(id: UUID().uuidString, text: message, time: getDateCurrent(date: Date()), files: [])
            // Parse Object a JSON
            let encodeData = try? JSONEncoder().encode(messageResponse)
            //            let jsonObject = try? JSONSerialization.jsonObject(with: encodeData!, options: .allowFragments)
            //
            let sendTo = XMPPJID(string: sendTo + "@" + hostDomain)
            let messageTo = XMPPMessage(type: "chat", to: sendTo)
            
            messageTo.addBody(String(data: encodeData!, encoding: .utf8)!)
            
        }
        
    }
    
    public func sendMessageAndFile(sendTo: String, message: String, filename: String, pathFile: String) {
        
        guard sendTo != "" else {
            print("Ingresar el destinatario")
            return
        }
        
        guard message != "" else {
            print("Ingresar el mensaje")
            return
        }
        
        if isAutoReconnecting {
            
            let messageResponse = TSMMessage(id: UUID().uuidString, text: message, time: getDateCurrent(date: Date()), files: [])
            // Parse a JSON
            let encodeData = try? JSONEncoder().encode(messageResponse)
            //
            let sendTo = XMPPJID(string: sendTo + "@" + hostDomain)
            let messageTo = XMPPMessage(type: "chat", to: sendTo)
            
            messageTo.addBody(String(data: encodeData!, encoding: .utf8)!)
        }
        
    }
    
    func sendMessageAndFileAsync(sendTo: String, message: String, filename: String, pathFile: String, completionHandler: TSMXMPPcompletionHandler) {
        
        guard sendTo != "" else {
            print("Ingresar el destinatario")
            return
        }
        
        guard message != "" else {
            print("Ingresar el mensaje")
            return
        }
        
        if isAutoReconnecting {
            
            let messageResponse = TSMMessage(id: UUID().uuidString, text: message, time: getDateCurrent(date: Date()), files: [])
            // Parse a JSON
            let encodeData = try? JSONEncoder().encode(messageResponse)
            //
            let sendTo = XMPPJID(string: sendTo + "@" + hostDomain)
            let messageTo = XMPPMessage(type: "chat", to: sendTo)
            
            messageTo.addBody(String(data: encodeData!, encoding: .utf8)!)
        }
        
    }
    
}
    
extension TSMXMPP: XMPPStreamDelegate {

    public func xmppStreamDidConnect(_ sender: XMPPStream) {
        print("Connected successlly.😀👍")
        print("Loggin in as " + sender.myJID!.full)
        
        do {
            try xmppStream.authenticate(withPassword: self.passwordJID)
        } catch let error as NSError  {
            print("Error authenticating 😡😡😡: " + error.debugDescription);
        }
    }
    
    public func xmppStreamDidAuthenticate(_ sender: XMPPStream) {
        print("Authenticated successfully. 😀👍")
        isAutoReconnecting = true
        let presence = XMPPPresence()
        xmppStream.send(presence)
    }
    
    public func xmppStreamDidDisconnect(_ sender: XMPPStream, withError error: Error?) {
        print("Stream disconnected with error 😡😡: " + error.debugDescription)
    }
    
    public func xmppStream(_ sender: XMPPStream, didNotAuthenticate error: XMLElement) {
        print("Authentication failed with error 😡😡: " + error.debugDescription)
    }
    
    public func xmppStream(_ sender: XMPPStream, didReceive presence: XMPPPresence) {
        let presenceUser = presence.prettyXMLString()
        print(presenceUser)
    }
    
    public func xmppStream(_ sender: XMPPStream, willSend message: XMPPMessage) -> XMPPMessage? {
        
        print("Will send message 🔜✉️")
        print(message.to!, message.from!, message.body!)
        
        // Parse JSON to Object
        let jsonData = message.body!.data(using: .utf8)!
        let messageResponse = try! JSONDecoder().decode(TSMMessage.self, from: jsonData)
        //
        
        self.xmppOutgoingMessageDelegate.willSendMessage(message: TSMMessageMapper.instances.transferMessage(tsmMessage: messageResponse))
        
        return message
    }
    
    public func xmppStream(_ sender: XMPPStream, willReceive message: XMPPMessage) -> XMPPMessage? {
        
        print("Will receive send message 👉✉️")
        print(message.to!, message.from!, message.body!)
        
        // Parse JSON to Object
        let jsonData = message.body!.data(using: .utf8)!
        let messageResponse = try! JSONDecoder().decode(TSMMessage.self, from: jsonData)
        //
        
        self.xmppOutgoingMessageDelegate.willReceiveSendMessage(message: TSMMessageMapper.instances.transferMessage(tsmMessage: messageResponse))
        
        return message
    }
    
    public func xmppStream(_ sender: XMPPStream, didReceive message: XMPPMessage) {
        print("Receive message 😃✉️ ")
        print(message.to!, message.from!, message.body!)
        
        // Parse JSON to Object
        let jsonData = message.body!.data(using: .utf8)!
        let messageResponse = try! JSONDecoder().decode(TSMMessage.self, from: jsonData)
        //
        
        self.xmppIncomingMessageDelegate.receivedMessage(message: TSMMessageMapper.instances.transferMessage(tsmMessage: messageResponse))
        
    }
    
    //    public func xmppStream(_ sender: XMPPStream!, didReceiveError error: DDXMLElement!) {
    //
    //    }
    
    public func xmppStream(_ sender: XMPPStream, didFailToSend message: XMPPMessage, error: Error) {
        self.xmppOutgoingMessageDelegate.didFailToSendMessage(error: error)
    }
}

