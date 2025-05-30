// swift-tools-version:6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

/*
 ** 2022-02-25
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
 ** Swift Package Manager manifest for the CSQLite package.
 */

import PackageDescription

/// Compile-time options
/// - seealso: [Recommended Compile-time Options](https://sqlite.org/compile.html#recommended_compile_time_options)
let compileTimeOptions: [CSetting] = [
	// https://sqlite.org/compile.html#dqs
	.define("SQLITE_DQS", to: "0", .when(traits: ["CSQLITE_DQS_0"])),
	// https://sqlite.org/compile.html#threadsafe
	.define("SQLITE_THREADSAFE", to: "0", .when(traits: ["CSQLITE_THREADSAFE_0"])),
	// https://sqlite.org/compile.html#default_memstatus
	.define("SQLITE_DEFAULT_MEMSTATUS", to: "0", .when(traits: ["CSQLITE_DEFAULT_MEMSTATUS_0"])),
	// https://sqlite.org/compile.html#default_wal_synchronous
	.define("SQLITE_DEFAULT_WAL_SYNCHRONOUS", to: "1", .when(traits: ["CSQLITE_DEFAULT_WAL_SYNCHRONOUS_1"])),
	// https://sqlite.org/compile.html#like_doesnt_match_blobs
	.define("SQLITE_LIKE_DOESNT_MATCH_BLOBS", .when(traits: ["CSQLITE_LIKE_DOESNT_MATCH_BLOBS"])),
	// https://sqlite.org/limits.html#max_expr_depth
	.define("SQLITE_MAX_EXPR_DEPTH", to: "0", .when(traits: ["CSQLITE_MAX_EXPR_DEPTH_0"])),
	// https://sqlite.org/compile.html#omit_decltype
	.define("SQLITE_OMIT_DECLTYPE", .when(traits: ["CSQLITE_OMIT_DECLTYPE"])),
	// https://sqlite.org/compile.html#omit_deprecated
	.define("SQLITE_OMIT_DEPRECATED", .when(traits: ["CSQLITE_OMIT_DEPRECATED"])),
	// https://sqlite.org/compile.html#omit_progress_callback
	.define("SQLITE_OMIT_PROGRESS_CALLBACK", .when(traits: ["CSQLITE_OMIT_PROGRESS_CALLBACK"])),
	// https://sqlite.org/compile.html#omit_shared_cache
	.define("SQLITE_OMIT_SHARED_CACHE", .when(traits: ["CSQLITE_OMIT_SHARED_CACHE"])),
	// https://sqlite.org/compile.html#use_alloca
	.define("SQLITE_USE_ALLOCA", .when(traits: ["CSQLITE_USE_ALLOCA"])),
	// https://sqlite.org/compile.html#omit_autoinit
	.define("SQLITE_OMIT_AUTOINIT", .when(traits: ["CSQLITE_OMIT_AUTOINIT"])),
	// https://sqlite.org/compile.html#strict_subtype
	.define("SQLITE_STRICT_SUBTYPE", to: "1", .when(traits: ["CSQLITE_STRICT_SUBTYPE_1"])),
]

/// Platform configuration
/// - seealso: [Platform Configuration](https://sqlite.org/compile.html#_platform_configuration)
let platformConfiguration: [CSetting] = [
	.define("HAVE_ISNAN", to: "1"),
	// 'strchrnul' is available on linux since glibc 2.1.1 (1999-05-24)
	.define("HAVE_STRCHRNUL", to: "1", .when(platforms: [.linux])),
	// 'strchrnul' is only available on macOS 15.4, iOS 18.4, tvOS 18.4, watchOS 11.4
	// and there is no way to specify a version in the build settings condition platform
	.define("HAVE_UTIME", to: "1"),
]

/// Features
/// - seealso: [Options To Enable Features Normally Turned Off](https://sqlite.org/compile.html#_options_to_enable_features_normally_turned_off)
let features: [CSetting] = [
	// https://sqlite.org/bytecodevtab.html
	.define("SQLITE_ENABLE_BYTECODE_VTAB", .when(traits: ["CSQLITE_ENABLE_BYTECODE_VTAB"])),
	// https://sqlite.org/c3ref/column_database_name.html
	.define("SQLITE_ENABLE_COLUMN_METADATA", .when(traits: ["CSQLITE_ENABLE_COLUMN_METADATA"])),
	// https://sqlite.org/dbpage.html
	.define("SQLITE_ENABLE_DBPAGE_VTAB", .when(traits: ["CSQLITE_ENABLE_DBPAGE_VTAB"])),
	// https://sqlite.org/dbstat.html
	.define("SQLITE_ENABLE_DBSTAT_VTAB", .when(traits: ["CSQLITE_ENABLE_DBSTAT_VTAB"])),
	// https://sqlite.org/fts5.html
	.define("SQLITE_ENABLE_FTS5", .when(traits: ["CSQLITE_ENABLE_FTS5"])),
	// https://sqlite.org/geopoly.html
	.define("SQLITE_ENABLE_GEOPOLY", .when(traits: ["CSQLITE_ENABLE_GEOPOLY"])),
//	.define("SQLITE_ENABLE_ICU", .when(traits: ["CSQLITE_ENABLE_ICU"])),
	// https://sqlite.org/lang_mathfunc.html
	.define("SQLITE_ENABLE_MATH_FUNCTIONS", .when(traits: ["CSQLITE_ENABLE_MATH_FUNCTIONS"])),
	// https://sqlite.org/c3ref/expanded_sql.html
	.define("SQLITE_ENABLE_NORMALIZE", .when(traits: ["CSQLITE_ENABLE_NORMALIZE"])),
	// https://sqlite.org/c3ref/preupdate_blobwrite.html
	.define("SQLITE_ENABLE_PREUPDATE_HOOK", .when(traits: ["CSQLITE_ENABLE_PREUPDATE_HOOK"])),
	// https://sqlite.org/rtree.html
	.define("SQLITE_ENABLE_RTREE", .when(traits: ["CSQLITE_ENABLE_RTREE"])),
	// https://sqlite.org/sessionintro.html
	.define("SQLITE_ENABLE_SESSION", .when(traits: ["CSQLITE_ENABLE_SESSION"])),
	// https://sqlite.org/c3ref/snapshot.html
	.define("SQLITE_ENABLE_SNAPSHOT", .when(traits: ["CSQLITE_ENABLE_SNAPSHOT"])),
	// https://sqlite.org/stmt.html
	.define("SQLITE_ENABLE_STMTVTAB", .when(traits: ["CSQLITE_ENABLE_STMTVTAB"])),
	// https://sqlite.org/fileformat2.html#stat4tab
	.define("SQLITE_ENABLE_STAT4", .when(traits: ["CSQLITE_ENABLE_STAT4"])),
]

let package = Package(
	name: "CSQLite",
	products: [
		// Products define the executables and libraries a package produces, making them visible to other packages.
		.library(
			name: "CSQLite",
			targets: [
				"CSQLite",
			]),
	],
	traits: [
		// Compile-time options
		.trait(
			name: "CSQLITE_DQS_0",
			description: "Disallow double-quoted string literals in DDL and DML"
		),
		.trait(
			name: "CSQLITE_THREADSAFE_0",
			description: "Omit all mutex and thread-safety logic"
		),
		.trait(
			name: "CSQLITE_DEFAULT_MEMSTATUS_0",
			description: "Disable memory allocation statistics by default"
		),
		.trait(
			name: "CSQLITE_DEFAULT_WAL_SYNCHRONOUS_1",
			description: "Use synchronous=NORMAL in WAL mode by default"
		),
		.trait(
			name: "CSQLITE_LIKE_DOESNT_MATCH_BLOBS",
			description: "Don't allow BLOB operands to LIKE and GLOB operators"
		),
		.trait(
			name: "CSQLITE_MAX_EXPR_DEPTH_0",
			description: "Disable all checking of the expression parse-tree depth"
		),
		.trait(
			name: "CSQLITE_OMIT_DECLTYPE",
			description: "Omit the ability to return the declared type of columns"
		),
		.trait(
			name: "CSQLITE_OMIT_DEPRECATED",
			description: "Omit deprecated interfaces and features"
		),
		.trait(
			name: "CSQLITE_OMIT_PROGRESS_CALLBACK",
			description: "Omit progress callback"
		),
		.trait(
			name: "CSQLITE_OMIT_SHARED_CACHE",
			description: "Omit shared cache support"
		),
		.trait(
			name: "CSQLITE_USE_ALLOCA",
			description: "Use alloca to dynamically allocate temporary stack space"
		),
		.trait(
			name: "CSQLITE_OMIT_AUTOINIT",
			description: "Omit automatic library initialization"
		),
		.trait(
			name: "CSQLITE_STRICT_SUBTYPE_1",
			description: "Cause application-defined SQL functions not registered with the SQLITE_RESULT_SUBTYPE property to raise an error when invoking sqlite3_result_subtype"
		),
		// Features
		.trait(
			name: "CSQLITE_ENABLE_BYTECODE_VTAB",
			description: "Enables bytecode and tables_used table-valued functions"
		),
		.trait(
			name: "CSQLITE_ENABLE_COLUMN_METADATA",
			description: "Enables column and table metadata functions"
		),
		.trait(
			name: "CSQLITE_ENABLE_DBPAGE_VTAB",
			description: "Enables the sqlite_dbpage virtual table"
		),
		.trait(
			name: "CSQLITE_ENABLE_DBSTAT_VTAB",
			description: "Enables the dbstat virtual table"
		),
		.trait(
			name: "CSQLITE_ENABLE_FTS5",
			description: "Enables version 5 of the full-text search engine (fts5)"
		),
		.trait(
			name: "CSQLITE_ENABLE_GEOPOLY",
			description: "Enables the Geopoly extension"
		),
		.trait(
			name: "CSQLITE_ENABLE_MATH_FUNCTIONS",
			description: "Enables the built-in SQL math functions"
		),
		.trait(
			name: "CSQLITE_ENABLE_NORMALIZE",
			description: "Enables the sqlite3_normalized_sql function"
		),
		.trait(
			name: "CSQLITE_ENABLE_PREUPDATE_HOOK",
			description: "Enables the pre-update hook"
		),
		.trait(
			name: "CSQLITE_ENABLE_RTREE",
			description: "Enables the R*Tree index extension"
		),
		.trait(
			name: "CSQLITE_ENABLE_SESSION",
			description: "Enables the pre-update hook and session extension",
			enabledTraits: [
				"CSQLITE_ENABLE_PREUPDATE_HOOK",
			]
		),
		.trait(
			name: "CSQLITE_ENABLE_SNAPSHOT",
			description: "Enables support for database snapshots"
		),
		.trait(
			name: "CSQLITE_ENABLE_STMTVTAB",
			description: "Enables the sqlite_stmt virtual table"
		),
		.trait(
			name: "CSQLITE_ENABLE_STAT4",
			description: "Enables the sqlite_stat4 table"
		),
		// Default traits
		.default(enabledTraits: [
			"CSQLITE_DQS_0",
			"CSQLITE_THREADSAFE_0",
			"CSQLITE_DEFAULT_MEMSTATUS_0",
			"CSQLITE_DEFAULT_WAL_SYNCHRONOUS_1",
			"CSQLITE_LIKE_DOESNT_MATCH_BLOBS",
			"CSQLITE_MAX_EXPR_DEPTH_0",
			"CSQLITE_OMIT_DECLTYPE",
			"CSQLITE_OMIT_DEPRECATED",
			"CSQLITE_OMIT_PROGRESS_CALLBACK",
			"CSQLITE_OMIT_SHARED_CACHE",
			"CSQLITE_USE_ALLOCA",
			"CSQLITE_OMIT_AUTOINIT",
			"CSQLITE_STRICT_SUBTYPE_1",
			"CSQLITE_ENABLE_FTS5",
			"CSQLITE_ENABLE_MATH_FUNCTIONS",
			"CSQLITE_ENABLE_RTREE",
			"CSQLITE_ENABLE_SNAPSHOT",
			"CSQLITE_ENABLE_STMTVTAB",
			"CSQLITE_ENABLE_STAT4",
		]),
	],
	targets: [
		// Targets are the basic building blocks of a package, defining a module or a test suite.
		// Targets can depend on other targets in this package and products from dependencies.
		.target(
			name: "CSQLite",
			cSettings: compileTimeOptions + platformConfiguration + features + [
				// For statically linking extensions
				// https://sqlite.org/loadext.html#statically_linking_a_run_time_loadable_extension
				.define("SQLITE_CORE", to: "1"),
			],
			linkerSettings: [
				.linkedLibrary("m"),
			]),
		.testTarget(
			name: "CSQLiteTests",
			dependencies: [
				"CSQLite",
			])
	],
	cLanguageStandard: .gnu11
)
