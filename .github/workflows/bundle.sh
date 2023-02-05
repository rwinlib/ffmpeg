#/bin/sh
set -e
PACKAGE=ffmpeg

# Update
pacman -Syy --noconfirm
OUTPUT=$(mktemp -d)

# Download files (-dd skips dependencies)
pkgs=$(echo mingw-w64-{i686,x86_64,ucrt-x86_64}-${PACKAGE})
deps=$(pacman -Si $pkgs | grep 'Depends On' | grep -o 'mingw-w64-[_.a-z0-9-]*')
URLS=$(pacman -Sp $pkgs $deps --cache=$OUTPUT)
VERSION=$(pacman -Si mingw-w64-x86_64-${PACKAGE} | awk '/^Version/{print $3}')

# Set version for next step
echo "::set-output name=VERSION::${VERSION}"
echo "::set-output name=PACKAGE::${PACKAGE}"
echo "Bundling $PACKAGE-$VERSION"
echo "# $PACKAGE $VERSION" > README.md
echo "" >> README.md

for URL in $URLS; do
  curl -OLs $URL
  FILE=$(basename $URL)
  echo "Extracting: $URL"
  echo " - $FILE" >> README.md
  tar xf $FILE -C ${OUTPUT}
  rm -f $FILE
done

# Copy libs
rm -Rf include lib*
mkdir -p lib/x64 lib-8.3.0/{x64,i386}
cp -v ${OUTPUT}/ucrt64/lib/*.a lib/x64/
cp -v ${OUTPUT}/mingw64/lib/*.a lib-8.3.0/x64/
cp -v ${OUTPUT}/mingw32/lib/*.a lib-8.3.0/i386/
cp -rv ${OUTPUT}/ucrt64/include .