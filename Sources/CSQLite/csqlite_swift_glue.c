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
 ** Wrappers for some C variadic functions used in SQLite to make them
 ** accessible from Swift.
 */

#include "csqlite_swift_glue.h"

char * csqlite_sqlite3_strdup(const char *s)
{
	return sqlite3_mprintf("%s", s);
}

// MARK: - SQLite library configuration

int csqlite_sqlite3_config_singlethread()
{
	return sqlite3_config(SQLITE_CONFIG_SINGLETHREAD);
}

int csqlite_sqlite3_config_multithread()
{
	return sqlite3_config(SQLITE_CONFIG_MULTITHREAD);
}

int csqlite_sqlite3_config_serialized()
{
	return sqlite3_config(SQLITE_CONFIG_SERIALIZED);
}

int csqlite_sqlite3_config_malloc(sqlite3_mem_methods *x)
{
	return sqlite3_config(SQLITE_CONFIG_MALLOC, x);
}

int csqlite_sqlite3_config_getmalloc(sqlite3_mem_methods *x)
{
	return sqlite3_config(SQLITE_CONFIG_GETMALLOC, x);
}

int csqlite_sqlite3_config_memstatus(int x)
{
	return sqlite3_config(SQLITE_CONFIG_MEMSTATUS, x);
}

int csqlite_sqlite3_config_pagecache(void *x, int y, int z)
{
	return sqlite3_config(SQLITE_CONFIG_PAGECACHE, x, y, z);
}

int csqlite_sqlite3_config_heap(void *x, int y, int z)
{
	return sqlite3_config(SQLITE_CONFIG_HEAP, x, y, z);
}

int csqlite_sqlite3_config_mutex(sqlite3_mutex_methods *x)
{
	return sqlite3_config(SQLITE_CONFIG_MUTEX, x);
}

int csqlite_sqlite3_config_getmutex(sqlite3_mutex_methods *x)
{
	return sqlite3_config(SQLITE_CONFIG_GETMUTEX, x);
}

int csqlite_sqlite3_config_lookaside(int x, int y)
{
	return sqlite3_config(SQLITE_CONFIG_LOOKASIDE, x);
}

int csqlite_sqlite3_config_pcache2(sqlite3_pcache_methods2 *x)
{
	return sqlite3_config(SQLITE_CONFIG_PCACHE2, x);
}

int csqlite_sqlite3_config_getpcache2(sqlite3_pcache_methods2 *x)
{
	return sqlite3_config(SQLITE_CONFIG_GETPCACHE2, x);
}

int csqlite_sqlite3_config_log(void(*x)(void *, int, const char *), void *y)
{
	return sqlite3_config(SQLITE_CONFIG_LOG, x, y);
}

int csqlite_sqlite3_config_uri(int x)
{
	return sqlite3_config(SQLITE_CONFIG_URI, x);
}

int csqlite_sqlite3_config_covering_index_scan(int x)
{
	return sqlite3_config(SQLITE_CONFIG_COVERING_INDEX_SCAN, x);
}

int csqlite_sqlite3_config_sqllog(void(*x)(void *, sqlite3 *, const char *, int), void *y)
{
	return sqlite3_config(SQLITE_CONFIG_SQLLOG, x, y);
}

int csqlite_sqlite3_config_mmap_size(sqlite3_int64 x, sqlite3_int64 y)
{
	return sqlite3_config(SQLITE_CONFIG_MMAP_SIZE, x, y);
}

int csqlite_sqlite3_config_pcache_hdrsz(int *x)
{
	return sqlite3_config(SQLITE_CONFIG_PCACHE_HDRSZ, x);
}

int csqlite_sqlite3_config_pmasz(unsigned int x)
{
	return sqlite3_config(SQLITE_CONFIG_PMASZ, x);
}

int csqlite_sqlite3_config_stmtjrnl_spill(int x)
{
	return sqlite3_config(SQLITE_CONFIG_STMTJRNL_SPILL, x);
}

int csqlite_sqlite3_config_sorterref_size(int x)
{
	return sqlite3_config(SQLITE_CONFIG_SORTERREF_SIZE, x);
}

int csqlite_sqlite3_config_memdb_maxsize(sqlite3_int64 x)
{
	return sqlite3_config(SQLITE_CONFIG_MEMDB_MAXSIZE, x);
}

// MARK: - Database connection configuration

int csqlite_sqlite3_db_config_enable_fkey(sqlite3 *db, int x, int *y)
{
	return sqlite3_db_config(db, SQLITE_DBCONFIG_ENABLE_FKEY, x, y);
}

int csqlite_sqlite3_db_config_enable_trigger(sqlite3 *db, int x, int *y)
{
	return sqlite3_db_config(db, SQLITE_DBCONFIG_ENABLE_TRIGGER, x, y);
}

int csqlite_sqlite3_db_config_enable_view(sqlite3 *db, int x, int *y)
{
	return sqlite3_db_config(db, SQLITE_DBCONFIG_ENABLE_VIEW, x, y);
}

int csqlite_sqlite3_db_config_enable_load_extension(sqlite3 *db, int x, int *y)
{
	return sqlite3_db_config(db, SQLITE_DBCONFIG_ENABLE_LOAD_EXTENSION, x, y);
}

int csqlite_sqlite3_db_config_no_ckpt_on_close(sqlite3 *db, int x, int *y)
{
	return sqlite3_db_config(db, SQLITE_DBCONFIG_NO_CKPT_ON_CLOSE, x, y);
}

int csqlite_sqlite3_db_config_enable_qpsg(sqlite3 *db, int x, int *y)
{
	return sqlite3_db_config(db, SQLITE_DBCONFIG_ENABLE_QPSG, x, y);
}

int csqlite_sqlite3_db_config_defensive(sqlite3 *db, int x, int *y)
{
	return sqlite3_db_config(db, SQLITE_DBCONFIG_DEFENSIVE, x, y);
}

int csqlite_sqlite3_db_config_writable_schema(sqlite3 *db, int x, int *y)
{
	return sqlite3_db_config(db, SQLITE_DBCONFIG_WRITABLE_SCHEMA, x, y);
}

int csqlite_sqlite3_db_config_legacy_alter_table(sqlite3 *db, int x, int *y)
{
	return sqlite3_db_config(db, SQLITE_DBCONFIG_LEGACY_ALTER_TABLE, x, y);
}

int csqlite_sqlite3_db_config_dqs_dml(sqlite3 *db, int x, int *y)
{
	return sqlite3_db_config(db, SQLITE_DBCONFIG_DQS_DML, x, y);
}

int csqlite_sqlite3_db_config_dqs_ddl(sqlite3 *db, int x, int *y)
{
	return sqlite3_db_config(db, SQLITE_DBCONFIG_DQS_DDL, x, y);
}

int csqlite_sqlite3_db_config_trusted_schema(sqlite3 *db, int x, int *y)
{
	return sqlite3_db_config(db, SQLITE_DBCONFIG_TRUSTED_SCHEMA, x, y);
}
