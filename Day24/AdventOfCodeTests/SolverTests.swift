//
//  SolverTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/5/20.
//

@testable import AdventOfCode
import XCTest

class SolverTests: XCTestCase {

    func testDirectionsFromString() {
        XCTAssertEqual(Direction.directions(from: "esenee"), [.east, .southEast, .northEast, .east])
    }
    
    func testPointTranslate() {
        XCTAssertEqual(Point(0, 0).translated(by: Direction.directions(from: "esew")), Point(1, -1))
        XCTAssertEqual(Point(0, 0).translated(by: Direction.directions(from: "nwwswee")), Point(0, 0))
    }
    
    func testExample() throws {
        let input =
        """
        sesenwnenenewseeswwswswwnenewsewsw
        neeenesenwnwwswnenewnwwsewnenwseswesw
        seswneswswsenwwnwse
        nwnwneseeswswnenewneswwnewseswneseene
        swweswneswnenwsewnwneneseenw
        eesenwseswswnenwswnwnwsewwnwsene
        sewnenenenesenwsewnenwwwse
        wenwwweseeeweswwwnwwe
        wsweesenenewnwwnwsenewsenwwsesesenwne
        neeswseenwwswnwswswnw
        nenwswwsewswnenenewsenwsenwnesesenew
        enewnwewneswsewnwswenweswnenwsenwsw
        sweneswneswneneenwnewenewwneswswnese
        swwesenesewenwneswnwwneseswwne
        enesenwswwswneneswsenwnewswseenwsese
        wnwnesenesenenwwnenwsewesewsesesew
        nenewswnwewswnenesenwnesewesw
        eneswnwswnwsenenwnwnwwseeswneewsenese
        neswnwewnwnwseenwseesewsenwsweewe
        wseweeenwnesenwwwswnew
        """
        
        let solver = Solver(input: input)
        XCTAssertEqual(solver.countBlackTiles(), 10)
    }

}
