//
//  UserDefaultsManager.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/29/24.
//

import Foundation

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    private let userDefaults = UserDefaults.standard
    
    private init() {}
    
    private enum Keys {
        static let ticketId = "ticketId"
        static let ticketPrice = "ticketPrice"
    }
    
    func saveTicketId(_ id: Int) {
        userDefaults.set(id, forKey: Keys.ticketId)
    }
    
    func getTicketId() -> Int? {
        return userDefaults.object(forKey: Keys.ticketId) as? Int
    }
    
    func saveTicketPrice(_ price: Int) {
        UserDefaults.standard.set(price, forKey: Keys.ticketPrice)
    }

    func getTicketPrice() -> Int {
        return UserDefaults.standard.integer(forKey: Keys.ticketPrice)
    }
    
    func removeTicketId() {
        userDefaults.removeObject(forKey: Keys.ticketId)
    }
}
