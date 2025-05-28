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
 ** Basic tests of CSQLite functionality.
 */

import XCTest
@testable import CSQLite

final class CSQLiteBasicTests: XCTestCase {
#if swift(<6.1) || OMIT_AUTOINIT
	override class func setUp() {
		super.setUp()
		// It's necessary to call sqlite3_initialize() since SQLITE_OMIT_AUTOINIT is defined
		XCTAssertEqual(sqlite3_initialize(), SQLITE_OK)
	}
#endif

	func testInsert() {
		var db: OpaquePointer?
		XCTAssertEqual(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil), SQLITE_OK)

		XCTAssertEqual(sqlite3_exec(db, "create table t1(a,b);", nil, nil, nil), SQLITE_OK)

		var stmt: OpaquePointer?
		XCTAssertEqual(sqlite3_prepare_v2(db, "insert into t1(a,b) values (?,?);", -1, &stmt, nil), SQLITE_OK)

		let rowCount = 42
		for i in 0..<rowCount {
			XCTAssertEqual(sqlite3_bind_int64(stmt, 1, sqlite3_int64(i*2)), SQLITE_OK)
			XCTAssertEqual(sqlite3_bind_int64(stmt, 2, sqlite3_int64(i*2+1)), SQLITE_OK)

			XCTAssertEqual(sqlite3_step(stmt), SQLITE_DONE)

			XCTAssertEqual(sqlite3_clear_bindings(stmt), SQLITE_OK)
			XCTAssertEqual(sqlite3_reset(stmt), SQLITE_OK)
		}

		XCTAssertEqual(sqlite3_finalize(stmt), SQLITE_OK)

		XCTAssertEqual(sqlite3_prepare_v2(db, "select count(*) from t1;", -1, &stmt, nil), SQLITE_OK)
		XCTAssertEqual(sqlite3_step(stmt), SQLITE_ROW)
		let count = Int(sqlite3_column_int64(stmt, 0))
		XCTAssertEqual(count, rowCount)

		XCTAssertEqual(sqlite3_finalize(stmt), SQLITE_OK)
		XCTAssertEqual(sqlite3_close(db), SQLITE_OK)
	}

	func testSelect() {
		var db: OpaquePointer?
		XCTAssertEqual(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil), SQLITE_OK)

		XCTAssertEqual(sqlite3_exec(db, "create table t1(a,b);", nil, nil, nil), SQLITE_OK)
		XCTAssertEqual(sqlite3_exec(db, "insert into t1(a,b) values (1,2);", nil, nil, nil), SQLITE_OK)

		var stmt: OpaquePointer?
		XCTAssertEqual(sqlite3_prepare_v2(db, "select a,b from t1;", -1, &stmt, nil), SQLITE_OK)

		var result = sqlite3_step(stmt)
		while result == SQLITE_ROW {
			XCTAssertEqual(sqlite3_column_int64(stmt, 0), 1)
			XCTAssertEqual(sqlite3_column_int64(stmt, 1), 2)
			result = sqlite3_step(stmt)
		}
		XCTAssertEqual(result, SQLITE_DONE)

		XCTAssertEqual(sqlite3_finalize(stmt), SQLITE_OK)
		XCTAssertEqual(sqlite3_close(db), SQLITE_OK)
	}
}
