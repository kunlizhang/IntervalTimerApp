//
//  SettingsStore.swift
//  Interval Timer | HIIT
//
//  Created by Kunli Zhang on 20/02/22.
//

import Foundation
import SwiftUI

class SettingsStore: ObservableObject {
    @Published var settings: Settings = Settings()
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("settings.data")
    }
    
    static func load() async throws -> Settings {
        try await withCheckedThrowingContinuation { continuation in
            load { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let settings):
                    continuation.resume(returning: settings)
                }
            }
        }
    }
    
    static func load(completion: @escaping (Result<Settings, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success(Settings()))
                    }
                    return
                }
                let theSettings = try JSONDecoder().decode(Settings.self, from:
                                                            file.availableData)
                DispatchQueue.main.async {
                    completion(.success(theSettings))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    @discardableResult
    static func save(settings: Settings) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            save(settings: settings) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let savedSettings):
                    continuation.resume(returning: savedSettings)
                }
            }
        }
    }
    
    static func save(settings: Settings, completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(settings)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(1))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
