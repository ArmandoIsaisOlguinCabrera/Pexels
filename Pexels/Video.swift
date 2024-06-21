//
//  Video.swift
//  Pexels
//
//  Created by Armando Isais Olguin Cabrera  on 20/06/24.
//

import Foundation
import RealmSwift

struct Video: Identifiable, Decodable {
    let id: Int
    let width: Int
    let height: Int
    let url: String
    let image: String
    let duration: Int
    let user: User
    let videoFiles: [VideoFile]
    let videoPictures: [VideoPicture]

    private enum CodingKeys: String, CodingKey {
        case id, width, height, url, image, duration, user
        case videoFiles = "video_files"
        case videoPictures = "video_pictures"
    }
}

struct User: Decodable {
    let id: Int
    let name: String
    let url: String
}

struct VideoFile: Decodable {
    let id: Int
    let quality: String
    let fileType: String
    let width: Int
    let height: Int
    let link: String

    private enum CodingKeys: String, CodingKey {
        case id, quality
        case fileType = "file_type"
        case width, height, link
    }
}

struct VideoPicture: Decodable {
    let id: Int
    let picture: String
    let nr: Int
}

class VideoObject: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var width: Int = 0
    @Persisted var height: Int = 0
    @Persisted var url: String = ""
    @Persisted var image: String = ""
    @Persisted var duration: Int = 0
    @Persisted var user: UserObject?
    @Persisted var videoFiles: List<VideoFileObject>
    @Persisted var videoPictures: List<VideoPictureObject>

    convenience init(video: Video) {
        self.init()
        self.id = video.id
        self.width = video.width
        self.height = video.height
        self.url = video.url
        self.image = video.image
        self.duration = video.duration
        self.user = UserObject(user: video.user)
        self.videoFiles.append(objectsIn: video.videoFiles.map(VideoFileObject.init))
        self.videoPictures.append(objectsIn: video.videoPictures.map(VideoPictureObject.init))
    }

    func asVideo() -> Video {
        return Video(
            id: id,
            width: width,
            height: height,
            url: url,
            image: image,
            duration: duration,
            user: user?.asUser() ?? User(id: 0, name: "", url: ""),
            videoFiles: videoFiles.map { $0.asVideoFile() },
            videoPictures: videoPictures.map { $0.asVideoPicture() }
        )
    }
}

class UserObject: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var url: String = ""

    convenience init(user: User) {
        self.init()
        self.id = user.id
        self.name = user.name
        self.url = user.url
    }

    func asUser() -> User {
        return User(id: id, name: name, url: url)
    }
}

class VideoFileObject: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var quality: String = ""
    @Persisted var fileType: String = ""
    @Persisted var width: Int = 0
    @Persisted var height: Int = 0
    @Persisted var link: String = ""

    convenience init(videoFile: VideoFile) {
        self.init()
        self.id = videoFile.id
        self.quality = videoFile.quality
        self.fileType = videoFile.fileType
        self.width = videoFile.width
        self.height = videoFile.height
        self.link = videoFile.link
    }

    func asVideoFile() -> VideoFile {
        return VideoFile(id: id, quality: quality, fileType: fileType, width: width, height: height, link: link)
    }
}

class VideoPictureObject: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var picture: String = ""
    @Persisted var nr: Int = 0

    convenience init(videoPicture: VideoPicture) {
        self.init()
        self.id = videoPicture.id
        self.picture = videoPicture.picture
        self.nr = videoPicture.nr
    }

    func asVideoPicture() -> VideoPicture {
        return VideoPicture(id: id, picture: picture, nr: nr)
    }
}
