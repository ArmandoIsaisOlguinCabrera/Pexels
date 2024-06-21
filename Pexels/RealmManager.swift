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

    private init() {}

    func saveVideos(_ videos: [Video]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(videos.map(VideoObject.init), update: .modified)
            }
        } catch {
            print("Error saving videos to Realm: \(error.localizedDescription)")
        }
    }

    func loadVideos() -> [Video] {
        do {
            let realm = try Realm()
            let videos = realm.objects(VideoObject.self).map { $0.asVideo() }
            return Array(videos)
        } catch {
            print("Error loading videos from Realm: \(error.localizedDescription)")
            return []
        }
    }
}
