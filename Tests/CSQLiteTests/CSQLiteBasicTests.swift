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

import Testing
@testable import CSQLite

#if swift(<6.1) || THREADSAFE_0
@MainActor
#endif
@Suite struct CSQLiteBasicTests {
#if swift(<6.1) || OMIT_AUTOINIT
	init() throws {
		// It's necessary to call sqlite3_initialize() since SQLITE_OMIT_AUTOINIT is defined
		try #require(sqlite3_initialize() == SQLITE_OK)
	}
#endif

	@Test func insert() {
		var db: OpaquePointer?
		#expect(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil) == SQLITE_OK)

		#expect(sqlite3_exec(db, "create table t1(a,b);", nil, nil, nil) == SQLITE_OK)

		var stmt: OpaquePointer?
		#expect(sqlite3_prepare_v2(db, "insert into t1(a,b) values (?,?);", -1, &stmt, nil) == SQLITE_OK)

		let rowCount = 42
		for i in 0..<rowCount {
			#expect(sqlite3_bind_int64(stmt, 1, sqlite3_int64(i*2)) == SQLITE_OK)
			#expect(sqlite3_bind_int64(stmt, 2, sqlite3_int64(i*2+1)) == SQLITE_OK)

			#expect(sqlite3_step(stmt) == SQLITE_DONE)

			#expect(sqlite3_clear_bindings(stmt) == SQLITE_OK)
			#expect(sqlite3_reset(stmt) == SQLITE_OK)
		}

		#expect(sqlite3_finalize(stmt) == SQLITE_OK)

		#expect(sqlite3_prepare_v2(db, "select count(*) from t1;", -1, &stmt, nil) == SQLITE_OK)
		#expect(sqlite3_step(stmt) == SQLITE_ROW)
		let count = Int(sqlite3_column_int64(stmt, 0))
		#expect(count == rowCount)

		#expect(sqlite3_finalize(stmt) == SQLITE_OK)
		#expect(sqlite3_close(db) == SQLITE_OK)
	}

	@Test func select() {
		var db: OpaquePointer?
		#expect(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil) == SQLITE_OK)

		#expect(sqlite3_exec(db, "create table t1(a,b);", nil, nil, nil) == SQLITE_OK)
		#expect(sqlite3_exec(db, "insert into t1(a,b) values (1,2);", nil, nil, nil) == SQLITE_OK)

		var stmt: OpaquePointer?
		#expect(sqlite3_prepare_v2(db, "select a,b from t1;", -1, &stmt, nil) == SQLITE_OK)

		var result = sqlite3_step(stmt)
		while result == SQLITE_ROW {
			#expect(sqlite3_column_int64(stmt, 0) == 1)
			#expect(sqlite3_column_int64(stmt, 1) == 2)
			result = sqlite3_step(stmt)
		}
		#expect(result == SQLITE_DONE)

		#expect(sqlite3_finalize(stmt) == SQLITE_OK)
		#expect(sqlite3_close(db) == SQLITE_OK)
	}
}
