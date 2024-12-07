#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "kuzya_bot::kuzya_bot" for configuration ""
set_property(TARGET kuzya_bot::kuzya_bot APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(kuzya_bot::kuzya_bot PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libkuzya_bot.so"
  IMPORTED_SONAME_NOCONFIG "libkuzya_bot.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS kuzya_bot::kuzya_bot )
list(APPEND _IMPORT_CHECK_FILES_FOR_kuzya_bot::kuzya_bot "${_IMPORT_PREFIX}/lib/libkuzya_bot.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
