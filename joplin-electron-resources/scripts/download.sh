set -e
VERSION=2.14.20
URL="https://github.com/laurent22/joplin/archive/refs/tags/v$VERSION.tar.gz"
echo "Downloading $URL"
wget -O joplin.tar.gz $URL
tar -xvzf joplin.tar.gz
rm joplin.tar.gz
mv joplin-$VERSION joplin
