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
	.define("SQLITE_DQS", to: "0"),
	// https://sqlite.org/compile.html#threadsafe
	.define("SQLITE_THREADSAFE", to: "0"),
	// https://sqlite.org/compile.html#default_memstatus
	.define("SQLITE_DEFAULT_MEMSTATUS", to: "0"),
	// https://sqlite.org/compile.html#default_wal_synchronous
	.define("SQLITE_DEFAULT_WAL_SYNCHRONOUS", to: "1"),
	// https://sqlite.org/compile.html#like_doesnt_match_blobs
	.define("SQLITE_LIKE_DOESNT_MATCH_BLOBS"),
	// https://sqlite.org/limits.html#max_expr_depth
	.define("SQLITE_MAX_EXPR_DEPTH", to: "0"),
	// https://sqlite.org/compile.html#omit_decltype
	.define("SQLITE_OMIT_DECLTYPE"),
	// https://sqlite.org/compile.html#omit_deprecated
	.define("SQLITE_OMIT_DEPRECATED"),
	// https://sqlite.org/compile.html#omit_progress_callback
	.define("SQLITE_OMIT_PROGRESS_CALLBACK"),
	// https://sqlite.org/compile.html#omit_shared_cache
	.define("SQLITE_OMIT_SHARED_CACHE"),
	// https://sqlite.org/compile.html#use_alloca
	.define("SQLITE_USE_ALLOCA"),
	// https://sqlite.org/compile.html#omit_autoinit
	.define("SQLITE_OMIT_AUTOINIT"),
	// https://sqlite.org/compile.html#strict_subtype
	.define("SQLITE_STRICT_SUBTYPE", to: "1"),
]

/// Platform configuration
/// - seealso: [Platform Configuration](https://sqlite.org/compile.html#_platform_configuration)
let platformConfiguration: [CSetting] = [
	.define("HAVE_ISNAN", to: "1"),
	.define("HAVE_UTIME", to: "1"),
]

/// Features
/// - seealso: [Options To Enable Features Normally Turned Off](https://sqlite.org/compile.html#_options_to_enable_features_normally_turned_off)
let features: [CSetting] = [
	// https://sqlite.org/c3ref/column_database_name.html
	.define("SQLITE_ENABLE_COLUMN_METADATA", .when( traits: ["SQLITE_ENABLE_COLUMN_METADATA"])),
	// https://sqlite.org/fts5.html
	.define("SQLITE_ENABLE_FTS5", .when(traits: ["SQLITE_ENABLE_FTS5"])),
	// https://sqlite.org/geopoly.html
	.define("SQLITE_ENABLE_GEOPOLY", .when(traits: ["SQLITE_ENABLE_GEOPOLY"])),
//	.define("SQLITE_ENABLE_ICU", .when(traits: ["SQLITE_ENABLE_ICU"])),
	// https://sqlite.org/lang_mathfunc.html
	.define("SQLITE_ENABLE_MATH_FUNCTIONS", .when(traits: ["SQLITE_ENABLE_MATH_FUNCTIONS"])),
	// https://sqlite.org/c3ref/preupdate_blobwrite.html
	.define("SQLITE_ENABLE_PREUPDATE_HOOK", .when(traits: ["SQLITE_ENABLE_PREUPDATE_HOOK"])),
	// https://sqlite.org/rtree.html
	.define("SQLITE_ENABLE_RTREE", .when(traits: ["SQLITE_ENABLE_RTREE"])),
	// https://sqlite.org/sessionintro.html
	.define("SQLITE_ENABLE_SESSION", .when(traits: ["SQLITE_ENABLE_SESSION"])),
	// https://sqlite.org/c3ref/snapshot.html
	.define("SQLITE_ENABLE_SNAPSHOT", .when(traits: ["SQLITE_ENABLE_SNAPSHOT"])),
	// https://sqlite.org/stmt.html
	.define("SQLITE_ENABLE_STMTVTAB", .when(traits: ["SQLITE_ENABLE_STMTVTAB"])),
	// https://sqlite.org/fileformat2.html#stat4tab
	.define("SQLITE_ENABLE_STAT4", .when(traits: ["SQLITE_ENABLE_STAT4"])),
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
		.trait(
			name: "SQLITE_ENABLE_COLUMN_METADATA",
			description: "Enables column and table metadata functions"
		),
		.trait(
			name: "SQLITE_ENABLE_FTS5",
			description: "Enables version 5 of the full-text search engine (fts5)"
		),
		.trait(
			name: "SQLITE_ENABLE_GEOPOLY",
			description: "Includes the Geopoly extension"
		),
		.trait(
			name: "SQLITE_ENABLE_MATH_FUNCTIONS",
			description: "Enables the built-in SQL math functions"
		),
		.trait(
			name: "SQLITE_ENABLE_PREUPDATE_HOOK",
			description: "Enables the pre-update hook"
		),
		.trait(
			name: "SQLITE_ENABLE_RTREE",
			description: "Enables the R*Tree index extension"
		),
		.trait(
			name: "SQLITE_ENABLE_SESSION",
			description: "Enables the preupdate hook and session extension",
			enabledTraits: [
				"SQLITE_ENABLE_PREUPDATE_HOOK",
			]
		),
		.trait(
			name: "SQLITE_ENABLE_SNAPSHOT",
			description: "Enables support for the sqlite3_snapshot object and associated functions"
		),
		.trait(
			name: "SQLITE_ENABLE_STMTVTAB",
			description: "Enables the SQLITE_STMT Virtual Table"
		),
		.trait(
			name: "SQLITE_ENABLE_STAT4",
			description: "Enables the sqlite_stat4 table"
		),
		.default(enabledTraits: [
			"SQLITE_ENABLE_FTS5",
			"SQLITE_ENABLE_MATH_FUNCTIONS",
			"SQLITE_ENABLE_RTREE",
			"SQLITE_ENABLE_STMTVTAB",
			"SQLITE_ENABLE_STAT4",
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
