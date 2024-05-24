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
 ** Functions to manage automatic database extension registration from Swift.
 */

#include "csqlite_extensions.h"
#include "sqlite3.h"

// MARK: - Database extensions

void sqlite3_carray_init();
int csqlite_sqlite3_auto_extension_carray()
{
	return sqlite3_auto_extension(sqlite3_carray_init);
}

int csqlite_sqlite3_cancel_auto_extension_carray()
{
	return sqlite3_cancel_auto_extension(sqlite3_carray_init);
}

void sqlite3_decimal_init();
int csqlite_sqlite3_auto_extension_decimal()
{
	return sqlite3_auto_extension(sqlite3_decimal_init);
}

int csqlite_sqlite3_cancel_auto_extension_decimal()
{
	return sqlite3_cancel_auto_extension(sqlite3_decimal_init);
}

void sqlite3_ieee_init();
int csqlite_sqlite3_auto_extension_ieee754()
{
	return sqlite3_auto_extension(sqlite3_ieee_init);
}

int csqlite_sqlite3_cancel_auto_extension_ieee754()
{
	return sqlite3_cancel_auto_extension(sqlite3_ieee_init);
}

void sqlite3_series_init();
int csqlite_sqlite3_auto_extension_series()
{
	return sqlite3_auto_extension(sqlite3_series_init);
}

int csqlite_sqlite3_cancel_auto_extension_series()
{
	return sqlite3_cancel_auto_extension(sqlite3_series_init);
}

void sqlite3_shathree_init();
int csqlite_sqlite3_auto_extension_sha3()
{
	return sqlite3_auto_extension(sqlite3_shathree_init);
}

int csqlite_sqlite3_cancel_auto_extension_sha3()
{
	return sqlite3_cancel_auto_extension(sqlite3_shathree_init);
}

void sqlite3_uuid_init();
int csqlite_sqlite3_auto_extension_uuid()
{
	return sqlite3_auto_extension(sqlite3_uuid_init);
}

int csqlite_sqlite3_cancel_auto_extension_uuid()
{
	return sqlite3_cancel_auto_extension(sqlite3_uuid_init);
}
