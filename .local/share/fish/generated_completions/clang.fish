# clang
# Autogenerated from man page /usr/share/man/man1/clang.1.gz
complete -c clang -s E -d 'Run the preprocessor stage'
complete -c clang -o fsyntax-only -d 'Run the preprocessor, parser and type checking stages'
complete -c clang -s S -d 'Run the previous stages as well as LLVM generation and optimization stages an…'
complete -c clang -s c -d 'Run all of the above, plus the assembler, generating a target "'
complete -c clang -s x -d 'Treat subsequent input files as having type language'
complete -c clang -o std -d 'Specify the language standard to compile for'
complete -c clang -o stdlib -d 'Specify the C++ standard library to use; supported options are libstdc++ and …'
complete -c clang -o rtlib -d 'Specify the compiler runtime library to use; supported options are libgcc and…'
complete -c clang -o ansi -d 'Same as -std=c89'
complete -c clang -o ObjC -o ObjC++ -d 'Treat source input files as Objective-C and Object-C++ inputs respectively'
complete -c clang -o trigraphs -d 'Enable trigraphs'
complete -c clang -o ffreestanding -d 'Indicate that the file should be compiled for a freestanding, not a hosted, e…'
complete -c clang -o fno-builtin -d 'Disable special handling and optimizations of builtin functions like strlen()…'
complete -c clang -o fmath-errno -d 'Indicate that math functions should be treated as updating errno'
complete -c clang -o fpascal-strings -d 'Enable support for Pascal-style strings with "pfoo"'
complete -c clang -o fms-extensions -d 'Enable support for Microsoft extensions'
complete -c clang -o fmsc-version -d 'Set _MSC_VER.  Defaults to 1300 on Windows.  Not set otherwise'
complete -c clang -o fborland-extensions -d 'Enable support for Borland extensions'
complete -c clang -o fwritable-strings -d 'Make all string literals default to writable'
complete -c clang -o flax-vector-conversions -o flax-vector-conversions -o fno-lax-vector-conversions -d 'Allow loose type checking rules for implicit vector conversions'
complete -c clang -o fblocks -d 'Enable the "Blocks" language feature'
complete -c clang -o fobjc-abi-version -d 'Select the Objective-C ABI version to use'
complete -c clang -o fobjc-nonfragile-abi-version -d 'Select the Objective-C non-fragile ABI version to use by default'
complete -c clang -o fobjc-nonfragile-abi -o fno-objc-nonfragile-abi -d 'Enable use of the Objective-C non-fragile ABI'
complete -c clang -o arch -d 'Specify the architecture to build for'
complete -c clang -o mmacosx-version-min -d 'When building for macOS, specify the minimum version supported by your applic…'
complete -c clang -o miphoneos-version-min -d 'When building for iPhone OS, specify the minimum version supported by your ap…'
complete -c clang -l print-supported-cpus -d 'Print out a list of supported processors for the given target (specified thro…'
complete -c clang -o mcpu -o mtune -d 'Aliases of --print-supported-cpus'
complete -c clang -o march -d 'Specify that Clang should generate code for a specific processor family membe…'
complete -c clang -o O0 -o O1 -o O2 -o O3 -o Ofast -o Os -o Oz -o Og -s O -o O4 -d 'Specify which optimization level to use: NDENT 7. 0 NDENT 3'
complete -c clang -s g -o gline-tables-only -o gmodules -d 'Control debug information output'
complete -c clang -o fstandalone-debug -o fno-standalone-debug -d 'Clang supports a number of optimizations to reduce the size of debug informat…'
complete -c clang -o fexceptions -d 'Enable generation of unwind information'
complete -c clang -o ftrapv -d 'Generate code to catch integer overflow errors'
complete -c clang -o fvisibility -d 'This flag sets the default visibility level'
complete -c clang -o fcommon -o fno-common -d 'This flag specifies that variables without initializers get common linkage'
complete -c clang -o ftls-model -d 'Set the default thread-local storage (TLS) model to use for thread-local vari…'
complete -c clang -o flto -o flto -o flto -o emit-llvm -d 'Generate output files in LLVM formats, suitable for link time optimization'
complete -c clang -o '###' -d 'Print (but do not run) the commands to run for this compilation'
complete -c clang -l help -d 'Display available options'
complete -c clang -o Qunused-arguments -d 'Do not emit any warnings for unused driver arguments'
complete -c clang -o Wa -d 'Pass the comma separated arguments in args to the assembler'
complete -c clang -o Wl -d 'Pass the comma separated arguments in args to the linker'
complete -c clang -o Wp -d 'Pass the comma separated arguments in args to the preprocessor'
complete -c clang -o Xanalyzer -d 'Pass arg to the static analyzer'
complete -c clang -o Xassembler -d 'Pass arg to the assembler'
complete -c clang -o Xlinker -d 'Pass arg to the linker'
complete -c clang -o Xpreprocessor -d 'Pass arg to the preprocessor'
complete -c clang -s o -d 'Write output to file'
complete -c clang -o print-file-name -d 'Print the full library path of file'
complete -c clang -o print-libgcc-file-name -d 'Print the library path for the currently used compiler runtime library ("libg…'
complete -c clang -o print-prog-name -d 'Print the full program path of name'
complete -c clang -o print-search-dirs -d 'Print the paths used for finding libraries and programs'
complete -c clang -o save-temps -d 'Save intermediate compilation results'
complete -c clang -o save-stats -o save-stats -o save-stats -d 'Save internal code generation (LLVM) statistics to a file in the current dire…'
complete -c clang -o integrated-as -o no-integrated-as -d 'Used to enable and disable, respectively, the use of the integrated assembler'
complete -c clang -o time -d 'Time individual commands'
complete -c clang -o ftime-report -d 'Print timing summary of each stage of compilation'
complete -c clang -s v -d 'Show commands to run and use verbose output'
complete -c clang -o fshow-column -o fshow-source-location -o fcaret-diagnostics -o fdiagnostics-fixit-info -o fdiagnostics-parseable-fixits -o fdiagnostics-print-source-range-info -o fprint-source-range-info -o fdiagnostics-show-option -o fmessage-length -d 'These options control how Clang prints out information about diagnostics (err…'
complete -c clang -o 'D<macroname>' -d 'Adds an implicit #define into the predefines buffer which is read before the …'
complete -c clang -o 'U<macroname>' -d 'Adds an implicit #undef into the predefines buffer which is read before the s…'
complete -c clang -o include -d 'Adds an implicit #include into the predefines buffer which is read before the…'
complete -c clang -o 'I<directory>' -d 'Add the specified directory to the search path for include files'
complete -c clang -o 'F<directory>' -d 'Add the specified directory to the search path for framework include files'
complete -c clang -o nostdinc -d 'Do not search the standard system directories or compiler builtin directories…'
complete -c clang -o nostdlibinc -d 'Do not search the standard system directories for include files, but do searc…'
complete -c clang -o nobuiltininc -d 'Do not search clang\\(aqs builtin directory for include files'
complete -c clang -o object_path_lto -d 'ld64 linker not to delete the temporary object file generated during Link Tim…'

