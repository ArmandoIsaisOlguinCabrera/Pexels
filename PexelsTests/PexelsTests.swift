//
//  PexelsTests.swift
//  PexelsTests
//
//  Created by Armando Isais Olguin Cabrera  on 20/06/24.
//

import XCTest
import Combine

@testable import Pexels

class PexelsTests: XCTestCase {
    var viewModel: VideoViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        viewModel = VideoViewModel()
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchVideos() {
        let expectation = XCTestExpectation(description: "Fetch videos from API")

        viewModel.$videos
            .dropFirst()
            .sink { videos in
                XCTAssertFalse(videos.isEmpty, "Videos should not be empty")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchVideos()

        wait(for: [expectation], timeout: 5.0)
    }
}
