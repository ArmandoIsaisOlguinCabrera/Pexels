//
//  RealmManager.swift
//  Pexels
//
//  Created by Armando Isais Olguin Cabrera  on 20/06/24.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    private var realm: Realm

    private init() {
        do {
            self.realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }

    // For testing purposes
    init(realm: Realm) {
        self.realm = realm
    }

    func saveVideos(_ videos: [Video]) {
        do {
            try realm.write {
                realm.add(videos.map(VideoObject.init), update: .modified)
            }
        } catch {
            print("Error saving videos to Realm: \(error.localizedDescription)")
        }
    }

    func loadVideos() -> [Video] {
        let videoObjects = realm.objects(VideoObject.self)
        return Array(videoObjects.map { $0.asVideo() })
    }
}
