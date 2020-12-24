//
//  TileFloorTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 12/5/20.
//

@testable import AdventOfCode
import XCTest

class TileFloorTests: XCTestCase {

    func testDirectionsFromString() {
        XCTAssertEqual(Direction.directions(from: "esenee"), [.east, .southEast, .northEast, .east])
    }
    
    func testHexagonalTileTranslate() {
        let originTile = HexagonalTile.origin
        XCTAssertEqual(originTile.translated(by: Direction.directions(from: "esew")), HexagonalTile(1, -1))
        XCTAssertEqual(originTile.translated(by: Direction.directions(from: "nwwswee")), HexagonalTile(0, 0))
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
        
        let floor = TileFloor(input: input)
        XCTAssertEqual(floor.countStartingBlackTiles(), 10)
        XCTAssertEqual(floor.simulateArtExhibit(days: 100), 2208)
    }

}
