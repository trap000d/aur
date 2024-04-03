set -e
pushd joplin
YARN_ENABLE_IMMUTABLE_INSTALLS=false SHARP_IGNORE_GLOBAL_LIBVIPS=true yarn install
popd
