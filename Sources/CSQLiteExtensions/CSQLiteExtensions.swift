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

#if false
@_exported import CSQLite
#endif

#if swift(<6.1) || CSQLITE_ENABLE_CARRAY_EXTENSION
@_exported import CSQLiteCArrayExtension
#endif

#if swift(<6.1) || CSQLITE_ENABLE_DECIMAL_EXTENSION
@_exported import CSQLiteDecimalExtension
#endif

#if swift(<6.1) || CSQLITE_ENABLE_IEEE754_EXTENSION
@_exported import CSQLiteIEEE754Extension
#endif

#if swift(<6.1) || CSQLITE_ENABLE_PERCENTILE_EXTENSION
@_exported import CSQLitePercentileExtension
#endif

#if swift(<6.1) || CSQLITE_ENABLE_SERIES_EXTENSION
@_exported import CSQLiteSeriesExtension
#endif

#if swift(<6.1) || CSQLITE_ENABLE_SHA3_EXTENSION
@_exported import CSQLiteSHA3Extension
#endif

#if swift(<6.1) || CSQLITE_ENABLE_UUID_EXTENSION
@_exported import CSQLiteUUIDExtension
#endif
