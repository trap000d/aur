set -e
pushd joplin
yarn workspace @joplin/app-desktop dist --linux --publish=never
popd
