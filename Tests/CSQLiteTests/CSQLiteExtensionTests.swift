/*
 ** 2021-06-08
 **
 ** The author disclaims copyright to this source code.  In place of
 ** a legal notice, here is a blessing:
 **
 **    May you do good and not evil.
 **    May you find forgiveness for yourself and forgive others.
 **    May you share freely, never taking more than you give.
 **
 ******************************************************************************
 **
 ** Basic tests of CSQLite statically-linked extension functionality.
 */

import XCTest
@testable import CSQLite

final class CSQLiteExtensionTests: XCTestCase {
	override class func setUp() {
		super.setUp()
#if OMIT_AUTOINIT
		// It's necessary to call sqlite3_initialize() since SQLITE_OMIT_AUTOINIT is defined
		XCTAssertEqual(sqlite3_initialize(), SQLITE_OK)
#endif
	}

	func testCarray() {
		XCTAssertEqual(csqlite_sqlite3_auto_extension_carray(), SQLITE_OK)

		var db: OpaquePointer?
		XCTAssertEqual(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil), SQLITE_OK)

		XCTAssertEqual(sqlite3_exec(db, "create table t1(a);", nil, nil, nil), SQLITE_OK)
		XCTAssertEqual(sqlite3_exec(db, "insert into t1(a) values (2),(3),(4),(5);", nil, nil, nil), SQLITE_OK)

		var stmt: OpaquePointer?
		XCTAssertEqual(sqlite3_prepare_v2(db, "select a from t1 where a in carray(?);", -1, &stmt, nil), SQLITE_OK)
		let array: [Int32] = [3,5];
		let mem = UnsafeMutableBufferPointer<Int32>.allocate(capacity: array.count)
		_ = mem.initialize(from: array)
		XCTAssertEqual(sqlite3_carray_bind(stmt, 1, mem.baseAddress, Int32(array.count), CARRAY_INT32, {
			$0?.deallocate()
		}), SQLITE_OK)
		XCTAssertEqual(sqlite3_step(stmt), SQLITE_ROW)
		XCTAssertEqual(sqlite3_column_int(stmt, 0), 3)
		XCTAssertEqual(sqlite3_step(stmt), SQLITE_ROW)
		XCTAssertEqual(sqlite3_column_int(stmt, 0), 5)

		XCTAssertEqual(sqlite3_finalize(stmt), SQLITE_OK)
		XCTAssertEqual(sqlite3_close(db), SQLITE_OK)
	}

	func testDecimal() {
		XCTAssertEqual(csqlite_sqlite3_auto_extension_decimal(), SQLITE_OK)

		var db: OpaquePointer?
		XCTAssertEqual(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil), SQLITE_OK)

		var stmt: OpaquePointer?
		XCTAssertEqual(sqlite3_prepare_v2(db, "select decimal_add('1.67','2.33');", -1, &stmt, nil), SQLITE_OK)
		XCTAssertEqual(sqlite3_step(stmt), SQLITE_ROW)
		let r = String(cString: sqlite3_column_text(stmt, 0))
		XCTAssertEqual(r, "4.00")

		XCTAssertEqual(sqlite3_finalize(stmt), SQLITE_OK)
		XCTAssertEqual(sqlite3_close(db), SQLITE_OK)
	}

	func testIEEE() {
		XCTAssertEqual(csqlite_sqlite3_auto_extension_ieee754(), SQLITE_OK)

		var db: OpaquePointer?
		XCTAssertEqual(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil), SQLITE_OK)

		var stmt: OpaquePointer?
		XCTAssertEqual(sqlite3_prepare_v2(db, "select ieee754(45.25);", -1, &stmt, nil), SQLITE_OK)
		XCTAssertEqual(sqlite3_step(stmt), SQLITE_ROW)
		let f = String(cString: sqlite3_column_text(stmt, 0))
		XCTAssertEqual(f, "ieee754(181,-2)")

		XCTAssertEqual(sqlite3_finalize(stmt), SQLITE_OK)
		XCTAssertEqual(sqlite3_close(db), SQLITE_OK)
	}

	func testPercentile() {
		XCTAssertEqual(csqlite_sqlite3_auto_extension_percentile(), SQLITE_OK)

		var db: OpaquePointer?
		XCTAssertEqual(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil), SQLITE_OK)

		var stmt: OpaquePointer?
		XCTAssertEqual(sqlite3_prepare_v2(db, "select median(33);", -1, &stmt, nil), SQLITE_OK)
		XCTAssertEqual(sqlite3_step(stmt), SQLITE_ROW)
		XCTAssertEqual(sqlite3_column_int(stmt, 0), 33)

		XCTAssertEqual(sqlite3_finalize(stmt), SQLITE_OK)
		XCTAssertEqual(sqlite3_close(db), SQLITE_OK)
	}

	func testSeries() {
		XCTAssertEqual(csqlite_sqlite3_auto_extension_series(), SQLITE_OK)

		var db: OpaquePointer?
		XCTAssertEqual(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil), SQLITE_OK)

		var stmt: OpaquePointer?
		XCTAssertEqual(sqlite3_prepare_v2(db, "select * from generate_series(10,20,5);", -1, &stmt, nil), SQLITE_OK)
		XCTAssertEqual(sqlite3_step(stmt), SQLITE_ROW)
		XCTAssertEqual(sqlite3_column_int(stmt, 0), 10)
		XCTAssertEqual(sqlite3_step(stmt), SQLITE_ROW)
		XCTAssertEqual(sqlite3_column_int(stmt, 0), 15)
		XCTAssertEqual(sqlite3_step(stmt), SQLITE_ROW)
		XCTAssertEqual(sqlite3_column_int(stmt, 0), 20)

		XCTAssertEqual(sqlite3_finalize(stmt), SQLITE_OK)
		XCTAssertEqual(sqlite3_close(db), SQLITE_OK)
	}

	func testSHA3() {
		XCTAssertEqual(csqlite_sqlite3_auto_extension_sha3(), SQLITE_OK)

		var db: OpaquePointer?
		XCTAssertEqual(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil), SQLITE_OK)

		var stmt: OpaquePointer?
		XCTAssertEqual(sqlite3_prepare_v2(db, "select lower(hex(sha3('sqlite')));", -1, &stmt, nil), SQLITE_OK)
		XCTAssertEqual(sqlite3_step(stmt), SQLITE_ROW)
		let h = String(cString: sqlite3_column_text(stmt, 0))
		XCTAssertEqual(h, "963a88636d4c9cc3f011dfc9dc0058e96669d80a89893c68c0bb08a6a8208db3")

		XCTAssertEqual(sqlite3_finalize(stmt), SQLITE_OK)
		XCTAssertEqual(sqlite3_close(db), SQLITE_OK)
	}

	func testUUID() {
		XCTAssertEqual(csqlite_sqlite3_auto_extension_uuid(), SQLITE_OK)

		var db: OpaquePointer?
		XCTAssertEqual(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil), SQLITE_OK)

		var stmt: OpaquePointer?
		XCTAssertEqual(sqlite3_prepare_v2(db, "select uuid();", -1, &stmt, nil), SQLITE_OK)
		XCTAssertEqual(sqlite3_step(stmt), SQLITE_ROW)
		let u = String(cString: sqlite3_column_text(stmt, 0))
		let comps = u.components(separatedBy: "-")
		XCTAssertEqual(comps.count, 5)
		XCTAssertEqual(comps[0].count, 8)
		XCTAssertEqual(comps[1].count, 4)
		XCTAssertEqual(comps[2].count, 4)
		XCTAssertEqual(comps[3].count, 4)
		XCTAssertEqual(comps[4].count, 12)
		let uu = UUID(uuidString: u)
		XCTAssertNotNil(uu)

		XCTAssertEqual(sqlite3_finalize(stmt), SQLITE_OK)
		XCTAssertEqual(sqlite3_close(db), SQLITE_OK)
	}
}
