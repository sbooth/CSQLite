/*
 ** 2025-05-30
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

#include "csqlite_decimal_extension.h"
#include "sqlite3.h"

void sqlite3_decimal_init(void);
int csqlite_sqlite3_auto_extension_decimal()
{
	return sqlite3_auto_extension(sqlite3_decimal_init);
}

int csqlite_sqlite3_cancel_auto_extension_decimal()
{
	return sqlite3_cancel_auto_extension(sqlite3_decimal_init);
}
