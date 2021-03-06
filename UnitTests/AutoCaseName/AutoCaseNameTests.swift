//
//  AutoCaseNameTests.swift
//  UnitTests
//
//  Created by Olivier HALLIGON on 25/05/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import XCTest

class AutoCaseNameTests: XCTestCase {

  func testStateCaseNames() {
    let state1 = State.notLoaded
    XCTAssertEqual(state1.caseName, .notLoaded)

    let state2 = State.loading(message: "Foo", percent: 0.42)
    XCTAssertEqual(state2.caseName, .loading)

    let state3 = State.loaded(data: ["Bar", "Baz"])
    XCTAssertEqual(state3.caseName, .loaded)

    let state4 = State.error(message: "Server Error", code: 500)
    XCTAssertEqual(state4.caseName, .error)
  }

  func testSyntaxes() {
    let state: State = State.loading(message: "Loading Data…", percent: 0.42)
    guard state.caseName != .error else {
      XCTFail("State's caseName should not be error")
      return
    }

    XCTAssert(state.caseName != .loaded)
    XCTAssertEqual(state.caseName.rawValue, "loading")
  }

  func testComparable() {
    let state1: State = State.loading(message: "Loading Data…", percent: 0.42)
    let state2: State = State.loading(message: "Loading…", percent: 0.1337)
    let state3: State = State.notLoaded

    XCTAssertEqual(state1.caseName, state2.caseName)
    XCTAssertNotEqual(state1.caseName, state3.caseName)
  }
}
