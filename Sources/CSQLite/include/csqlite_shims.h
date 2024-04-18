/*
 ** 2021-05-29
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

/// Copies `s` into memory allocated by `sqlite3_malloc()` and returns the result
char * csqlite_sqlite3_strdup(const char *s);

// MARK: - SQLite library configuration
// See https://sqlite.org/c3ref/config.html

/// Equivalent to `sqlite3_config(SQLITE_CONFIG_SINGLETHREAD)`
int csqlite_sqlite3_config_singlethread(void);
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_MULTITHREAD)`
int csqlite_sqlite3_config_multithread(void);
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_SERIALIZED)`
int csqlite_sqlite3_config_serialized(void);
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_MALLOC, x)`
int csqlite_sqlite3_config_malloc(sqlite3_mem_methods *x);
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_GETMALLOC, x)`
int csqlite_sqlite3_config_getmalloc(sqlite3_mem_methods *x);
// SQLITE_CONFIG_SCRATCH no longer used
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_PAGECACHE, x, sz, N)`
int csqlite_sqlite3_config_pagecache(void *x, int sz, int N);
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_HEAP, x, nByte, min)`
int csqlite_sqlite3_config_heap(void *x, int nByte, int min);
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_MEMSTATUS, x)`
int csqlite_sqlite3_config_memstatus(int x);
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_MUTEX, x)`
int csqlite_sqlite3_config_mutex(sqlite3_mutex_methods *x);
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_GETMUTEX, x)`
int csqlite_sqlite3_config_getmutex(sqlite3_mutex_methods *x);
// SQLITE_CONFIG_CHUNKALLOC now unused
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_LOOKASIDE, x, y)`
int csqlite_sqlite3_config_lookaside(int x, int y);
// SQLITE_CONFIG_PCACHE no-op
// SQLITE_CONFIG_GETPCACHE no-op
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_LOG, x, y)`
int csqlite_sqlite3_config_log(void(*x)(void *, int, const char *), void *y);
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_URI, x)`
int csqlite_sqlite3_config_uri(int x);
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_PCACHE2, x)`
int csqlite_sqlite3_config_pcache2(sqlite3_pcache_methods2 *x);
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_GETPCACHE2, x)`
int csqlite_sqlite3_config_getpcache2(sqlite3_pcache_methods2 *x);
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_COVERING_INDEX_SCAN, x)`
int csqlite_sqlite3_config_covering_index_scan(int x);
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_SQLLOG, x, y)`
int csqlite_sqlite3_config_sqllog(void(*x)(void *, sqlite3 *, const char *, int), void *y);
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_MMAP_SIZE, x, y)`
int csqlite_sqlite3_config_mmap_size(sqlite3_int64 x, sqlite3_int64 y);
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_WIN32_HEAPSIZE, nByte)`
int csqlite_sqlite3_config_win32_heapsize(int nByte);
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_PCACHE_HDRSZ, psz)`
int csqlite_sqlite3_config_pcache_hdrsz(int *psz);
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_PMASZ, szPma)`
int csqlite_sqlite3_config_pmasz(unsigned int szPma);
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_STMTJRNL_SPILL, nByte)`
int csqlite_sqlite3_config_stmtjrnl_spill(int nByte);
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_SMALL_MALLOC, x)`
int csqlite_sqlite3_config_small_malloc(int x);
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_SORTERREF_SIZE, nByte)`
int csqlite_sqlite3_config_sorterref_size(int nByte);
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_MEMDB_MAXSIZE, x)`
int csqlite_sqlite3_config_memdb_maxsize(sqlite3_int64 x);
/// Equivalent to `sqlite3_config(SQLITE_CONFIG_ROWID_IN_VIEW, x)`
int csqlite_sqlite3_config_rowid_in_view(int *x);

// MARK: - Database connection configuration
// See https://sqlite.org/c3ref/db_config.html

/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_MAINDBNAME, x)`
int csqlite_sqlite3_db_config_maindbname(sqlite3 *db, char *x);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_LOOKASIDE, x, y, z)`
int csqlite_sqlite3_db_config_lookaside(sqlite3 *db, void *x, int y, int z);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_ENABLE_FKEY, x, y)`
int csqlite_sqlite3_db_config_enable_fkey(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_ENABLE_TRIGGER, x, y)`
int csqlite_sqlite3_db_config_enable_trigger(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_ENABLE_FTS3_TOKENIZER, x, y)`
int csqlite_sqlite3_db_config_enable_ft3_tokenizer(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_ENABLE_LOAD_EXTENSION, x, y)`
int csqlite_sqlite3_db_config_enable_load_extension(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_NO_CKPT_ON_CLOSE, x, y)`
int csqlite_sqlite3_db_config_no_ckpt_on_close(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_ENABLE_QPSG, x, y)`
int csqlite_sqlite3_db_config_enable_qpsg(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_TRIGGER_EQP, x, y)`
int csqlite_sqlite3_db_config_trigger_eqp(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_RESET_DATABASE, x, y)`
int csqlite_sqlite3_db_config_reset_database(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_DEFENSIVE, x, y)`
int csqlite_sqlite3_db_config_defensive(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_WRITABLE_SCHEMA, x, y)`
int csqlite_sqlite3_db_config_writable_schema(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_LEGACY_ALTER_TABLE, x, y)`
int csqlite_sqlite3_db_config_legacy_alter_table(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_DQS_DML, x, y)`
int csqlite_sqlite3_db_config_dqs_dml(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_DQS_DDL, x, y)`
int csqlite_sqlite3_db_config_dqs_ddl(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_ENABLE_VIEW, x, y)`
int csqlite_sqlite3_db_config_enable_view(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_LEGACY_FILE_FORMAT, x, y)`
int csqlite_sqlite3_db_config_legacy_file_format(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_TRUSTED_SCHEMA, x, y)`
int csqlite_sqlite3_db_config_trusted_schema(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_STMT_SCANSTATUS, x, y)`
int csqlite_sqlite3_db_config_stmt_scanstatus(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_REVERSE_SCANORDER, x, y)`
int csqlite_sqlite3_db_config_reverse_scanorder(sqlite3 *db, int x, int *y);

// MARK: - Virtual table configuration
// See https://sqlite.org/c3ref/vtab_config.html

/// Equivalent to `sqlite3_vtab_config(db, SQLITE_VTAB_CONSTRAINT_SUPPORT, x)`
int csqlite_sqlite3_vtab_config_constraint_support(sqlite3 *db, int x);
/// Equivalent to `sqlite3_vtab_config(db, SQLITE_VTAB_INNOCUOUS)`
int csqlite_sqlite3_vtab_config_innocuous(sqlite3 *db);
/// Equivalent to `sqlite3_vtab_config(db, SQLITE_VTAB_DIRECTONLY)`
int csqlite_sqlite3_vtab_config_directonly(sqlite3 *db);
/// Equivalent to `sqlite3_vtab_config(db, SQLITE_VTAB_USES_ALL_SCHEMAS)`
int csqlite_sqlite3_vtab_uses_all_schemas(sqlite3 *db);

// MARK: - Database extensions
// See https://sqlite.org/loadext.html

/// Equivalent to `sqlite3_auto_extension(sqlite3_carray_init)`
int csqlite_sqlite3_auto_extension_carray(void);
/// Equivalent to `sqlite3_cancel_auto_extension(sqlite3_carray_init)`
int csqlite_sqlite3_cancel_auto_extension_carray(void);

/// Equivalent to `sqlite3_auto_extension(sqlite3_decimal_init)`
int csqlite_sqlite3_auto_extension_decimal(void);
/// Equivalent to `sqlite3_cancel_auto_extension(sqlite3_decimal_init)`
int csqlite_sqlite3_cancel_auto_extension_decimal(void);

/// Equivalent to `sqlite3_auto_extension(sqlite3_ieee_init)`
int csqlite_sqlite3_auto_extension_ieee754(void);
/// Equivalent to `sqlite3_cancel_auto_extension(sqlite3_ieee_init)`
int csqlite_sqlite3_cancel_auto_extension_ieee754(void);

/// Equivalent to `sqlite3_auto_extension(sqlite3_series_init)`
int csqlite_sqlite3_auto_extension_series(void);
/// Equivalent to `sqlite3_cancel_auto_extension(sqlite3_series_init)`
int csqlite_sqlite3_cancel_auto_extension_series(void);

/// Equivalent to `sqlite3_auto_extension(sqlite3_shathree_init)`
int csqlite_sqlite3_auto_extension_sha3(void);
/// Equivalent to `sqlite3_cancel_auto_extension(sqlite3_shathree_init)`
int csqlite_sqlite3_cancel_auto_extension_sha3(void);

/// Equivalent to `sqlite3_auto_extension(sqlite3_uuid_init)`
int csqlite_sqlite3_auto_extension_uuid(void);
/// Equivalent to `sqlite3_cancel_auto_extension(sqlite3_uuid_init)`
int csqlite_sqlite3_cancel_auto_extension_uuid(void);
