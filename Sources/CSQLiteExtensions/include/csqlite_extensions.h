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

// MARK: - Database extensions
// See https://sqlite.org/loadext.html

#if __has_include("csqlite_carray_extension.h")
#include "csqlite_carray_extension.h"
#endif

#if __has_include("csqlite_decimal_extension.h")
#include "csqlite_decimal_extension.h"
#endif

#if __has_include("csqlite_ieee754_extension.h")
#include "csqlite_ieee754_extension.h"
#endif

#if __has_include("csqlite_percentile_extension.h")
#include "csqlite_percentile_extension.h"
#endif

#if __has_include("csqlite_series_extension.h")
#include "csqlite_series_extension.h"
#endif

#if __has_include("csqlite_sha3_extension.h")
#include "csqlite_sha3_extension.h"
#endif

#if __has_include("csqlite_uuid_extension.h")
#include "csqlite_uuid_extension.h"
#endif
