/*
 ** 2021-06-04
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
 ** Wrappers for C functions not easily accessible from Swift.
 */

// MARK: - Database extensions
// See https://sqlite.org/loadext.html

/// Equivalent to `sqlite3_auto_extension(sqlite3_carray_init)`
int csqlite_sqlite3_auto_extension_carray();
/// Equivalent to `sqlite3_cancel_auto_extension(sqlite3_carray_init)`
int csqlite_sqlite3_cancel_auto_extension_carray();

/// Equivalent to `sqlite3_auto_extension(sqlite3_decimal_init)`
int csqlite_sqlite3_auto_extension_decimal();
/// Equivalent to `sqlite3_cancel_auto_extension(sqlite3_decimal_init)`
int csqlite_sqlite3_cancel_auto_extension_decimal();

/// Equivalent to `sqlite3_auto_extension(sqlite3_ieee_init)`
int csqlite_sqlite3_auto_extension_ieee754();
/// Equivalent to `sqlite3_cancel_auto_extension(sqlite3_ieee_init)`
int csqlite_sqlite3_cancel_auto_extension_ieee754();

/// Equivalent to `sqlite3_auto_extension(sqlite3_series_init)`
int csqlite_sqlite3_auto_extension_series();
/// Equivalent to `sqlite3_cancel_auto_extension(sqlite3_series_init)`
int csqlite_sqlite3_cancel_auto_extension_series();

/// Equivalent to `sqlite3_auto_extension(sqlite3_shathree_init)`
int csqlite_sqlite3_auto_extension_sha3();
/// Equivalent to `sqlite3_cancel_auto_extension(sqlite3_shathree_init)`
int csqlite_sqlite3_cancel_auto_extension_sha3();

/// Equivalent to `sqlite3_auto_extension(sqlite3_uuid_init)`
int csqlite_sqlite3_auto_extension_uuid();
/// Equivalent to `sqlite3_cancel_auto_extension(sqlite3_uuid_init)`
int csqlite_sqlite3_cancel_auto_extension_uuid();
