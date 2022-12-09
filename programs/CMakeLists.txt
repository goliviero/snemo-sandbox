# - Executable:
add_executable(SNEMO-sandbox-trigger_word_simple_parse  trigger_word_simple_parse.cxx)

target_link_libraries(SNEMO-sandbox-trigger_word_simple_parse PUBLIC
# SNFrontEndElectronics::snfee
# Falaise::Falaise
)

# - Executable:
add_executable(SNEMO-sandbox-generate_geiger_matrix generate_geiger_matrix.cxx)

target_link_libraries(SNEMO-sandbox-generate_geiger_matrix PUBLIC
# SNFrontEndElectronics::snfee
# Falaise::Falaise
)

message(STATUS "CMAKE_INSTALL_PREFIX='${CMAKE_INSTALL_PREFIX}'")

# - Install if required - change install path with option DCMAKE_INSTALL_PREFIX:PATH=""
install(TARGETS SNEMO-sandbox-trigger_word_simple_parse SNEMO-sandbox-generate_geiger_matrix
  DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
)
