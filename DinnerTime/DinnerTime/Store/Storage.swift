//
//  Storage.swift
//  DinnerTime
//
//  Created by Ben Scheirman on 6/5/21.
//

import Foundation

class Storage<T: Codable> {
    let filename: String
    let encoder: JSONEncoder
    let decoder: JSONDecoder
    
    var storageURL: URL {
        let appSupport = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first!
        return URL(fileURLWithPath: appSupport).appendingPathComponent(filename)
    }
    
    init(filename: String) {
        self.filename = filename
        
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
    }
    
    func load() throws -> T? {
        guard FileManager.default.fileExists(atPath: storageURL.path) else { return nil }
        let data = try Data(contentsOf: storageURL)
        return try decoder.decode(T.self, from: data)
    }
    
    func save(_ object: T) throws {
        try ensureDirectoryExists()
        let data = try encoder.encode(object)
        try data.write(to: storageURL)
    }
    
    func removeAllData() throws {
        try FileManager.default.removeItem(at: storageURL)
    }
    
    private func ensureDirectoryExists() throws {
        // ensure directory exists
        let dir = storageURL.deletingLastPathComponent()
        
        if !FileManager.default.fileExists(atPath: dir.path) {
            try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true, attributes: nil)
        }
    }
}
