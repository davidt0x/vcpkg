vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO libusb/hidapi
    REF ad7cc64ee1fce66806dd471216dbdc8555557e5b # use commit from cmake-support
    SHA512 5fd1e49538308c3d9146be1ca32bcf5f2c88a19f3240ee80ad7f6aceace4bc185c558bbce0b71ddf7029b95fc3b37cf805e8a3af23c4f69126666d1a1a10af06
    HEAD_REF cmake-support
    PATCHES 
    	"move-include-gnu-install-dirs.patch"
)

vcpkg_configure_cmake(
	SOURCE_PATH ${SOURCE_PATH}
	PREFER_NINJA
	OPTIONS -DBUILD_HIDTEST=0
)
	
vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/${PORT})

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
	file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin" "${CURRENT_PACKAGES_DIR}/debug/bin")
endif()
