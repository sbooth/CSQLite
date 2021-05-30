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

#include "sqlite3.h"

/// Duplicates and returns `s` using memory allocated by `sqlite3_malloc()`
char * sqlite3_swift_glue_strdup(const char *s);

/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_ENABLE_FKEY, x, y)`
int sqlite3_swift_glue_db_config_enable_fkey(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_ENABLE_TRIGGER, x, y)`
int sqlite3_swift_glue_db_config_enable_trigger(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_ENABLE_VIEW, x, y)`
int sqlite3_swift_glue_db_config_enable_view(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_ENABLE_LOAD_EXTENSION, x, y)`
int sqlite3_swift_glue_db_config_enable_load_extension(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_NO_CKPT_ON_CLOSE, x, y)`
int sqlite3_swift_glue_db_config_no_ckpt_on_close(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_ENABLE_QPSG, x, y)`
int sqlite3_swift_glue_db_config_enable_qpsg(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_DEFENSIVE, x, y)`
int sqlite3_swift_glue_db_config_defensive(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_WRITABLE_SCHEMA, x, y)`
int sqlite3_swift_glue_db_config_writable_schema(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_LEGACY_ALTER_TABLE, x, y)`
int sqlite3_swift_glue_db_config_legacy_alter_table(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_DQS_DML, x, y)`
int sqlite3_swift_glue_db_config_dqs_dml(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_DQS_DDL, x, y)`
int sqlite3_swift_glue_db_config_dqs_ddl(sqlite3 *db, int x, int *y);
/// Equivalent to `sqlite3_db_config(db, SQLITE_DBCONFIG_TRUSTED_SCHEMA, x, y)`
int sqlite3_swift_glue_db_config_trusted_schema(sqlite3 *db, int x, int *y);
