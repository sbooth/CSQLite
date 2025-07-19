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
 ** Basic tests of CSQLite features.
 */

import Testing
@testable import CSQLite

#if swift(<6.1) || THREADSAFE_0
@MainActor
#endif
@Suite struct CSQLiteFeatureTests {
#if swift(<6.1) || OMIT_AUTOINIT
	init() throws {
		// It's necessary to call sqlite3_initialize() since SQLITE_OMIT_AUTOINIT is defined
		try #require(sqlite3_initialize() == SQLITE_OK)
	}
#endif

#if swift(<6.1) || ENABLE_FTS5
	@Test func fts5() {
		var db: OpaquePointer?
		#expect(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil) == SQLITE_OK)

		#expect(sqlite3_exec(db, "CREATE VIRTUAL TABLE email USING fts5(sender, title, body);", nil, nil, nil) == SQLITE_OK)
		#expect(sqlite3_exec(db, "INSERT INTO email VALUES ('tina', 'fts', ''), ('bill', 'fts5', '');", nil, nil, nil) == SQLITE_OK)

		var stmt: OpaquePointer?
		#expect(sqlite3_prepare_v2(db, "SELECT * FROM email WHERE email MATCH 'fts5' ORDER BY rank;", -1, &stmt, nil) == SQLITE_OK)

		#expect(sqlite3_step(stmt) == SQLITE_ROW)
		let u = String(cString: sqlite3_column_text(stmt, 0))
		#expect(u == "bill")

		#expect(sqlite3_finalize(stmt) == SQLITE_OK)
		#expect(sqlite3_close(db) == SQLITE_OK)
	}
#endif

#if swift(<6.1) || ENABLE_MATH_FUNCTIONS
	@Test func mathFunctions() {
		var db: OpaquePointer?
		#expect(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil) == SQLITE_OK)

		var stmt: OpaquePointer?
		#expect(sqlite3_prepare_v2(db, "select pi();", -1, &stmt, nil) == SQLITE_OK)

		#expect(sqlite3_step(stmt) == SQLITE_ROW)
		#expect(sqlite3_column_double(stmt, 0) < 3.2)

		#expect(sqlite3_finalize(stmt) == SQLITE_OK)
		#expect(sqlite3_close(db) == SQLITE_OK)
	}
#endif

#if swift(<6.1) || ENABLE_RTREE
	@Test func rTree() {
		var db: OpaquePointer?
		#expect(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil) == SQLITE_OK)

		#expect(sqlite3_exec(db, "CREATE VIRTUAL TABLE demo_index USING rtree(id,minX, maxX,minY, maxY);", nil, nil, nil) == SQLITE_OK)
		#expect(sqlite3_exec(db, "INSERT INTO demo_index VALUES (28215, -80.781227, -80.604706, 35.208813, 35.297367), (28216, -80.957283, -80.840599, 35.235920, 35.367825), (28217, -80.960869, -80.869431, 35.133682, 35.208233), (28226, -80.878983, -80.778275, 35.060287, 35.154446), (28227, -80.745544, -80.555382, 35.130215, 35.236916), (28244, -80.844208, -80.841988, 35.223728, 35.225471), (28262, -80.809074, -80.682938, 35.276207, 35.377747), (28269, -80.851471, -80.735718, 35.272560, 35.407925), (28270, -80.794983, -80.728966, 35.059872, 35.161823), (28273, -80.994766, -80.875259, 35.074734, 35.172836), (28277, -80.876793, -80.767586, 35.001709, 35.101063), (28278, -81.058029, -80.956375, 35.044701, 35.223812), (28280, -80.844208, -80.841972, 35.225468, 35.227203), (28282, -80.846382, -80.844193, 35.223972, 35.225655);", nil, nil, nil) == SQLITE_OK)

		var stmt: OpaquePointer?
		#expect(sqlite3_prepare_v2(db, "SELECT id FROM demo_index WHERE minX<=-80.77470 AND maxX>=-80.77470 AND minY<=35.37785 AND maxY>=35.37785;", -1, &stmt, nil) == SQLITE_OK)

		#expect(sqlite3_step(stmt) == SQLITE_ROW)
		#expect(sqlite3_column_int64(stmt, 0) == 28269)

		#expect(sqlite3_finalize(stmt) == SQLITE_OK)
		#expect(sqlite3_close(db) == SQLITE_OK)
	}
#endif

#if swift(<6.1) || ENABLE_STMTVTAB
	@Test func stmtVtab() {
		var db: OpaquePointer?
		#expect(sqlite3_open_v2(":memory:", &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil) == SQLITE_OK)

		var stmt: OpaquePointer?
		#expect(sqlite3_prepare_v2(db, "select * from sqlite_stmt;", -1, &stmt, nil) == SQLITE_OK)
		#expect(sqlite3_step(stmt) == SQLITE_ROW)

		#expect(sqlite3_finalize(stmt) == SQLITE_OK)
		#expect(sqlite3_close(db) == SQLITE_OK)
	}
#endif
}
