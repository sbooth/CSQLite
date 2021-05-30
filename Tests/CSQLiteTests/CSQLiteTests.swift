import XCTest
@testable import CSQLite

final class CSQLiteTests: XCTestCase {
	override class func setUp() {
		super.setUp()
		// It's necessary to call sqlite3_initialize() since SQLITE_OMIT_AUTOINIT is defined
		XCTAssert(sqlite3_initialize() == SQLITE_OK)
	}

	func testInsert() {
		var db: OpaquePointer?
		sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil)

		sqlite3_exec(db, "create table t1(a, b);", nil, nil, nil)

		var stmt: OpaquePointer?
		sqlite3_prepare_v2(db, "insert into t1(a, b) values (?, ?);", -1, &stmt, nil)

		let rowCount = 42
		for i in 0..<rowCount {
			sqlite3_bind_int64(stmt, 1, sqlite3_int64(i*2))
			sqlite3_bind_int64(stmt, 2, sqlite3_int64(i*2+1))

			sqlite3_step(stmt)

			sqlite3_clear_bindings(stmt)
			sqlite3_reset(stmt)
		}

		sqlite3_finalize(stmt)

		sqlite3_prepare_v2(db, "select count(*) from t1;", -1, &stmt, nil)
		sqlite3_step(stmt)
		let count = Int(sqlite3_column_int64(stmt, 0))

		sqlite3_finalize(stmt)
		sqlite3_close(db)

		XCTAssertEqual(count, rowCount)
	}

	func testSelect() {
		var db: OpaquePointer?
		sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil)

		sqlite3_exec(db, "create table t1(a, b);", nil, nil, nil)

		var stmt: OpaquePointer?
		sqlite3_prepare_v2(db, "insert into t1(a, b) values (1, 2);", -1, &stmt, nil)
		sqlite3_step(stmt)
		sqlite3_finalize(stmt)

		sqlite3_prepare_v2(db, "select a, b from t1;", -1, &stmt, nil)

		var result = sqlite3_step(stmt)
		while result == SQLITE_ROW {
			let a = Int(sqlite3_column_int64(stmt, 0))
			XCTAssert(a == 1)
			let b = Int(sqlite3_column_int64(stmt, 1))
			XCTAssert(b == 2)
			result = sqlite3_step(stmt)
		}

		sqlite3_finalize(stmt)
		sqlite3_close(db)
	}
}
