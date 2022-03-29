#
# Generated file, do not edit.
#

list(APPEND FLUTTER_PLUGIN_LIST
<<<<<<< HEAD
  flutter_secure_storage_windows
  url_launcher_windows
=======
>>>>>>> d687317c1fc7d5316356a18e5eb4791748743c7d
)

set(PLUGIN_BUNDLED_LIBRARIES)

foreach(plugin ${FLUTTER_PLUGIN_LIST})
  add_subdirectory(flutter/ephemeral/.plugin_symlinks/${plugin}/windows plugins/${plugin})
  target_link_libraries(${BINARY_NAME} PRIVATE ${plugin}_plugin)
  list(APPEND PLUGIN_BUNDLED_LIBRARIES $<TARGET_FILE:${plugin}_plugin>)
  list(APPEND PLUGIN_BUNDLED_LIBRARIES ${${plugin}_bundled_libraries})
endforeach(plugin)
