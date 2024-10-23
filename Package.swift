// swift-tools-version:5.3
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

// For pre-update hook support:
//  - Uncomment lines containing `SQLITE_ENABLE_PREUPDATE_HOOK`
//
// For session support:
//  - Uncomment lines containing `SQLITE_ENABLE_PREUPDATE_HOOK`
//  - Uncomment lines containing `SQLITE_ENABLE_SESSION`

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
	targets: [
		// Targets are the basic building blocks of a package, defining a module or a test suite.
		// Targets can depend on other targets in this package and products from dependencies.
		.target(
			name: "CSQLite",
			cSettings: [
				// Compile-time options
				// https://sqlite.org/compile.html#recommended_compile_time_options
				.define("SQLITE_DQS", to: "0"),
				.define("SQLITE_THREADSAFE", to: "0"),
				.define("SQLITE_DEFAULT_MEMSTATUS", to: "0"),
				.define("SQLITE_DEFAULT_WAL_SYNCHRONOUS", to: "1"),
				.define("SQLITE_LIKE_DOESNT_MATCH_BLOBS"),
				.define("SQLITE_MAX_EXPR_DEPTH", to: "0"),
				.define("SQLITE_OMIT_DECLTYPE"),
				.define("SQLITE_OMIT_DEPRECATED"),
				.define("SQLITE_OMIT_PROGRESS_CALLBACK"),
				.define("SQLITE_OMIT_SHARED_CACHE"),
				.define("SQLITE_USE_ALLOCA"),
				.define("SQLITE_OMIT_AUTOINIT"),
				.define("SQLITE_STRICT_SUBTYPE", to: "1"),
				// Platform configuration
				// https://sqlite.org/compile.html#_platform_configuration
				.define("HAVE_ISNAN", to: "1"),
				.define("HAVE_UTIME", to: "1"),
				// Features
				// https://sqlite.org/compile.html#_options_to_enable_features_normally_turned_off
//				.define("SQLITE_ENABLE_COLUMN_METADATA"),
				.define("SQLITE_ENABLE_FTS5"),
//				.define("SQLITE_ENABLE_GEOPOLY"),
//				.define("SQLITE_ENABLE_ICU"),
				.define("SQLITE_ENABLE_MATH_FUNCTIONS"),
//				.define("SQLITE_ENABLE_PREUPDATE_HOOK"),
				.define("SQLITE_ENABLE_RTREE"),
//				.define("SQLITE_ENABLE_SESSION"),
				.define("SQLITE_ENABLE_SNAPSHOT"),
				.define("SQLITE_ENABLE_STMTVTAB"),
				.define("SQLITE_ENABLE_STAT4"),
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
