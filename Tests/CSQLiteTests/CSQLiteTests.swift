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
		XCTAssert(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil) == SQLITE_OK)

		XCTAssert(sqlite3_exec(db, "create table t1(a,b);", nil, nil, nil) == SQLITE_OK)

		var stmt: OpaquePointer?
		XCTAssert(sqlite3_prepare_v2(db, "insert into t1(a, b) values (?,?);", -1, &stmt, nil) == SQLITE_OK)

		let rowCount = 42
		for i in 0..<rowCount {
			XCTAssert(sqlite3_bind_int64(stmt, 1, sqlite3_int64(i*2)) == SQLITE_OK)
			XCTAssert(sqlite3_bind_int64(stmt, 2, sqlite3_int64(i*2+1)) == SQLITE_OK)

			XCTAssert(sqlite3_step(stmt) == SQLITE_DONE)

			XCTAssert(sqlite3_clear_bindings(stmt) == SQLITE_OK)
			XCTAssert(sqlite3_reset(stmt) == SQLITE_OK)
		}

		XCTAssert(sqlite3_finalize(stmt) == SQLITE_OK)

		XCTAssert(sqlite3_prepare_v2(db, "select count(*) from t1;", -1, &stmt, nil) == SQLITE_OK)
		XCTAssert(sqlite3_step(stmt) == SQLITE_ROW)
		let count = Int(sqlite3_column_int64(stmt, 0))
		XCTAssertEqual(count, rowCount)

		XCTAssert(sqlite3_finalize(stmt) == SQLITE_OK)
		XCTAssert(sqlite3_close(db) == SQLITE_OK)
	}

	func testSelect() {
		var db: OpaquePointer?
		XCTAssert(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil) == SQLITE_OK)

		XCTAssert(sqlite3_exec(db, "create table t1(a,b);", nil, nil, nil) == SQLITE_OK)
		XCTAssert(sqlite3_exec(db, "insert into t1(a,b) values (1,2);", nil, nil, nil) == SQLITE_OK)

		var stmt: OpaquePointer?
		XCTAssert(sqlite3_prepare_v2(db, "select a,b from t1;", -1, &stmt, nil) == SQLITE_OK)

		var result = sqlite3_step(stmt)
		while result == SQLITE_ROW {
			let a = Int(sqlite3_column_int64(stmt, 0))
			XCTAssert(a == 1)
			let b = Int(sqlite3_column_int64(stmt, 1))
			XCTAssert(b == 2)
			result = sqlite3_step(stmt)
		}
		XCTAssert(result == SQLITE_DONE)

		XCTAssert(sqlite3_finalize(stmt) == SQLITE_OK)
		XCTAssert(sqlite3_close(db) == SQLITE_OK)
	}

	func testCarray() {
		XCTAssert(csqlite_sqlite3_auto_extension_carray() == SQLITE_OK)

		var db: OpaquePointer?
		XCTAssert(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil) == SQLITE_OK)

		XCTAssert(sqlite3_exec(db, "create table t1(a);", nil, nil, nil) == SQLITE_OK)
		XCTAssert(sqlite3_exec(db, "insert into t1(a) values (2),(3),(4),(5);", nil, nil, nil) == SQLITE_OK)

		var stmt: OpaquePointer?
		XCTAssert(sqlite3_prepare_v2(db, "select a from t1 where a in carray(?);", -1, &stmt, nil) == SQLITE_OK)
		let array: [Int32] = [3,5];
		let mem = UnsafeMutableBufferPointer<Int32>.allocate(capacity: array.count)
		_ = mem.initialize(from: array)
		XCTAssert(sqlite3_carray_bind(stmt, 1, mem.baseAddress, Int32(array.count), CARRAY_INT32, {
			$0?.deallocate()
		}) == SQLITE_OK)
		XCTAssert(sqlite3_step(stmt) == SQLITE_ROW)
		var i = sqlite3_column_int(stmt, 0)
		XCTAssertEqual(i, 3)
		XCTAssert(sqlite3_step(stmt) == SQLITE_ROW)
		i = sqlite3_column_int(stmt, 0)
		XCTAssertEqual(i, 5)

		XCTAssert(sqlite3_finalize(stmt) == SQLITE_OK)
		XCTAssert(sqlite3_close(db) == SQLITE_OK)
	}

	func testDecimal() {
		XCTAssert(csqlite_sqlite3_auto_extension_decimal() == SQLITE_OK)

		var db: OpaquePointer?
		XCTAssert(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil) == SQLITE_OK)

		var stmt: OpaquePointer?
		XCTAssert(sqlite3_prepare_v2(db, "select decimal_add('1.67','2.33');", -1, &stmt, nil) == SQLITE_OK)
		XCTAssert(sqlite3_step(stmt) == SQLITE_ROW)
		let r = String(cString: sqlite3_column_text(stmt, 0))
		XCTAssertEqual(r, "4.00")

		XCTAssert(sqlite3_finalize(stmt) == SQLITE_OK)
		XCTAssert(sqlite3_close(db) == SQLITE_OK)
	}

	func testIEEE() {
		XCTAssert(csqlite_sqlite3_auto_extension_ieee754() == SQLITE_OK)

		var db: OpaquePointer?
		XCTAssert(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil) == SQLITE_OK)

		var stmt: OpaquePointer?
		XCTAssert(sqlite3_prepare_v2(db, "select ieee754(45.25);", -1, &stmt, nil) == SQLITE_OK)
		XCTAssert(sqlite3_step(stmt) == SQLITE_ROW)
		let f = String(cString: sqlite3_column_text(stmt, 0))
		XCTAssertEqual(f, "ieee754(181,-2)")

		XCTAssert(sqlite3_finalize(stmt) == SQLITE_OK)
		XCTAssert(sqlite3_close(db) == SQLITE_OK)
	}

	func testSeries() {
		XCTAssert(csqlite_sqlite3_auto_extension_series() == SQLITE_OK)

		var db: OpaquePointer?
		XCTAssert(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil) == SQLITE_OK)

		var stmt: OpaquePointer?
		XCTAssert(sqlite3_prepare_v2(db, "select * from generate_series(10,20,5);", -1, &stmt, nil) == SQLITE_OK)
		XCTAssert(sqlite3_step(stmt) == SQLITE_ROW)
		var i = sqlite3_column_int(stmt, 0)
		XCTAssertEqual(i, 10)
		XCTAssert(sqlite3_step(stmt) == SQLITE_ROW)
		i = sqlite3_column_int(stmt, 0)
		XCTAssertEqual(i, 15)
		XCTAssert(sqlite3_step(stmt) == SQLITE_ROW)
		i = sqlite3_column_int(stmt, 0)
		XCTAssertEqual(i, 20)

		XCTAssert(sqlite3_finalize(stmt) == SQLITE_OK)
		XCTAssert(sqlite3_close(db) == SQLITE_OK)
	}

	func testSHA1() {
		XCTAssert(csqlite_sqlite3_auto_extension_sha1() == SQLITE_OK)

		var db: OpaquePointer?
		XCTAssert(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil) == SQLITE_OK)

		var stmt: OpaquePointer?
		XCTAssert(sqlite3_prepare_v2(db, "select sha1('sqlite');", -1, &stmt, nil) == SQLITE_OK)
		XCTAssert(sqlite3_step(stmt) == SQLITE_ROW)
		let h = String(cString: sqlite3_column_text(stmt, 0))
		XCTAssertEqual(h, "6d64a5ee3d4875588bfd6dfd8a79cc338887ac1d")

		XCTAssert(sqlite3_finalize(stmt) == SQLITE_OK)
		XCTAssert(sqlite3_close(db) == SQLITE_OK)
	}

	func testSHA3() {
		XCTAssert(csqlite_sqlite3_auto_extension_sha3() == SQLITE_OK)

		var db: OpaquePointer?
		XCTAssert(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil) == SQLITE_OK)

		var stmt: OpaquePointer?
		XCTAssert(sqlite3_prepare_v2(db, "select lower(hex(sha3('sqlite')));", -1, &stmt, nil) == SQLITE_OK)
		XCTAssert(sqlite3_step(stmt) == SQLITE_ROW)
		let h = String(cString: sqlite3_column_text(stmt, 0))
		XCTAssertEqual(h, "963a88636d4c9cc3f011dfc9dc0058e96669d80a89893c68c0bb08a6a8208db3")

		XCTAssert(sqlite3_finalize(stmt) == SQLITE_OK)
		XCTAssert(sqlite3_close(db) == SQLITE_OK)
	}

	func testUUID() {
		XCTAssert(csqlite_sqlite3_auto_extension_uuid() == SQLITE_OK)

		var db: OpaquePointer?
		XCTAssert(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil) == SQLITE_OK)

		var stmt: OpaquePointer?
		XCTAssert(sqlite3_prepare_v2(db, "select uuid();", -1, &stmt, nil) == SQLITE_OK)
		XCTAssert(sqlite3_step(stmt) == SQLITE_ROW)
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

		XCTAssert(sqlite3_finalize(stmt) == SQLITE_OK)
		XCTAssert(sqlite3_close(db) == SQLITE_OK)
	}
}
