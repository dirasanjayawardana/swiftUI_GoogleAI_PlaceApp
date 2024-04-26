//
//  RemoteConfigService.swift
//  PlacesGoogleAI
//
//  Created by MACBOOK PRO on 26/04/24.
//

import Foundation
import Firebase

class RemoteConfigService: RemoteConfigurable {
    static let shared = RemoteConfigService()
    
    // variabel untuk interval fetch data ke firebase remote config dari local code
    private var remoteConfig = RemoteConfig.remoteConfig()
    
    private init() {
        configure()
    }
    
    func configure() {
        #if DEBUG
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        #else
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 8400 // untuk di production ubah interval sesuai kebutuhan (misal 24jam)
        #endif
        
        remoteConfig.configSettings = settings
    }
    
    // fetch dan activate configuration, simpan hasilnya sebagai status
    func fetchConfig<T: Decodable>(forKey key: ConfigKeys) async throws -> T {
        let status = try await remoteConfig.fetchAndActivate()
        
        switch status {
        case .successFetchedFromRemote:
            print("Configuration fetched from remote and activated")
        case .successUsingPreFetchedData:
            print("Pre-fetched data available and activated")
        case .error:
            print("An error occured while fetching remote config")
        @unknown default:
            print("An unknown status was returned")
        }
        
        // pastikan bahwa nilai dari config value yang kita set di firebase remote berupa string
        let stringValue = remoteConfig.configValue(forKey: key.rawValue).stringValue ?? ""
        
        print("Fetched value for \(key.rawValue): \(stringValue)")
        
        if T.self == String.self, let stringValue = stringValue as? T {
            return stringValue
        }
        
        // jika ketika didecode, generic T buka string, guard agar tidak crash
        guard let data = stringValue.data(using: .utf8) else {
            throw ErrorConfiguration.failedToConveretData(key: key.rawValue)
        }
        
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch {
            throw ErrorConfiguration.failedToDecodedData(key: key.rawValue, underlyingError: error)
        }
    }
}

protocol RemoteConfigurable {
    func fetchConfig<T: Decodable>(forKey key: ConfigKeys) async throws -> T
}

enum ConfigKeys: String {
    case apiKey = "API_KEY"
}

enum ErrorConfiguration: Error, LocalizedError {
    case failedToDecodedData(key: String, underlyingError: Error)
    
    case failedToConveretData(key: String)
    
    var errorDescription: String? {
        switch self {
        case .failedToDecodedData(let key, let underlyingError):
            return "Failed to decoded configuration for key: \(key). Error: \(underlyingError.localizedDescription)"
        case .failedToConveretData(key: let key):
            return "Failed to convert configuration for key: \(key) to Data"
        }
    }
}
