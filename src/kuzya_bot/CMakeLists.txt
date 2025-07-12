cmake_minimum_required(VERSION 3.16)
project(kuzya_bot  LANGUAGES CXX)

#if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
#  add_compile_options(-Wall -Wextra -Wpedantic)
#endif()

# find dependencies
##find_package(ament_cmake REQUIRED)
# uncomment the following section in order to fill in
# further dependencies manually.
# find_package(<dependency> REQUIRED)

#if(BUILD_TESTING)
#  find_package(ament_lint_auto REQUIRED)
  # the following line skips the linter which checks for copyrights
  # comment the line when a copyright and license is added to all source files
#  set(ament_cmake_copyright_FOUND TRUE)
  # the following line skips cpplint (only works in a git repo)
  # comment the line when this package is in a git repo and when
  # a copyright and license is added to all source files
#  set(ament_cmake_cpplint_FOUND TRUE)
#  ament_lint_auto_find_test_dependencies()
#endif()

#ament_package()

#=====================
if(CMAKE_CXX_COMPILER_ID MATCHES "(GNU|Clang)")
  add_compile_options(-Wall -Wextra)
endif()

# set the same behavior for windows as it is on linux
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

# find dependencies
set(THIS_PACKAGE_INCLUDE_DEPENDS
  hardware_interface
  pluginlib
  rclcpp
  rclcpp_lifecycle
)

# find dependencies
find_package(backward_ros REQUIRED)
find_package(ament_cmake REQUIRED)
foreach(Dependency IN ITEMS ${THIS_PACKAGE_INCLUDE_DEPENDS})
  find_package(${Dependency} REQUIRED)
endforeach()

## COMPILE
add_library(
  kuzya_bot
  SHARED
  hardware/diffbot_system.cpp
)
target_compile_features(kuzya_bot PUBLIC cxx_std_17)
target_include_directories(kuzya_bot PUBLIC
$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/hardware/include>
$<INSTALL_INTERFACE:include/kuzya_bot>
)

ament_target_dependencies(
  kuzya_bot PUBLIC
  ${THIS_PACKAGE_INCLUDE_DEPENDS}
)

target_link_libraries(kuzya_bot PUBLIC serial)

# Export hardware plugins
pluginlib_export_plugin_description_file(hardware_interface kuzya_bot.xml)

# INSTALL
install(
  DIRECTORY hardware/include/
  DESTINATION include/kuzya_bot
)
install(
  DIRECTORY description/launch description/ros2_control description/urdf
  DESTINATION share/kuzya_bot
)
install(
  DIRECTORY description/launch description/ros2_control description/urdf description/rviz
  DESTINATION share/kuzya_bot
)
install(
  DIRECTORY bringup/launch bringup/config
  DESTINATION share/kuzya_bot
)
install(TARGETS kuzya_bot
  EXPORT export_kuzya_bot
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
)

if(BUILD_TESTING)
  find_package(ament_cmake_pytest REQUIRED)

  ament_add_pytest_test(kuzya_bot_urdf_xacro test/test_urdf_xacro.py)
  ament_add_pytest_test(view_kuzya_bot_launch test/test_view_robot_launch.py)
  ament_add_pytest_test(run_kuzya_bot_launch test/test_diffbot_launch.py)
endif()

## EXPORTS
ament_export_targets(export_kuzya_bot HAS_LIBRARY_TARGET)
ament_export_dependencies(${THIS_PACKAGE_INCLUDE_DEPENDS})
ament_package()
