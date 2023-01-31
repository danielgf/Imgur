//
//  GalleryViewModelTests.swift
//  ImgurTests
//
//  Created by Daniel Griso Filho on 31/01/23.
//

import XCTest
import Combine
@testable import Imgur

final class GalleryViewModelTests: XCTestCase {
    
    var viewModelMock: GalleryViewModelMock?
    var cancellables = Set<AnyCancellable>()
    fileprivate var valueSpy: ValueSpy?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModelMock = GalleryViewModelMock()
        valueSpy = ValueSpy(viewModelMock!.valuePublisher)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModelMock = nil
        valueSpy = nil
    }

    func testExample() throws {
        
        viewModelMock?.fetchAPI()
        
        XCTAssertEqual(valueSpy?.title, "No lieutenant, your men are already dead")
        XCTAssertEqual(valueSpy?.cover, "D4eIMgp")
        XCTAssertEqual(valueSpy?.imageLink, "https://i.imgur.com/D4eIMgp.jpg")
        
    }

}

private class ValueSpy {
    private(set) var title = ""
    private(set) var cover = ""
    private(set) var imageLink = ""
    private var cancellable = Set<AnyCancellable>()
    
    init(_ publiser: AnyPublisher<GalleryObject?, Never>) {
        publiser.sink { [weak self] object in
            self?.title = object?.title ?? ""
            self?.cover = object?.cover ?? ""
            self?.imageLink = object?.imageLink ?? ""
        }.store(in: &cancellable)
    }
}
