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

#include "sqlite3.h"

// MARK: - Database extensions
// See https://sqlite.org/loadext.html

// The Carray() Table-Valued Function
// See https://sqlite.org/carray.html

/*
 ** Interface definitions for the CARRAY table-valued function
 ** extension.
 */

/* Use this interface to bind an array to the single-argument version
 ** of CARRAY().
 */
int sqlite3_carray_bind(
  sqlite3_stmt *pStmt,        /* Statement to be bound */
  int i,                      /* Parameter index */
  void *aData,                /* Pointer to array data */
  int nData,                  /* Number of data elements */
  int mFlags,                 /* CARRAY flags */
  void (*xDel)(void*)         /* Destructor for aData*/
);

/* Allowed values for the mFlags parameter to sqlite3_carray_bind().
 */
#define CARRAY_INT32     0    /* Data is 32-bit signed integers */
#define CARRAY_INT64     1    /* Data is 64-bit signed integers */
#define CARRAY_DOUBLE    2    /* Data is doubles */
#define CARRAY_TEXT      3    /* Data is char* */

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
