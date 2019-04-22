{stdenv, qt48Full}:

let srcs = {
    qcustomplot_super = builtins.fetchurl {
        url = "https://www.qcustomplot.com/release/2.0.1/QCustomPlot-source.tar.gz";
        sha256 = "574cee47def3251d080168a23428859214277cb9b6876bcdb9ce9d00b2403fe4";
    };
    qcustomplot_sharedlib = builtins.fetchurl {
        url = "https://www.qcustomplot.com/release/2.0.1/QCustomPlot-sharedlib.tar.gz";
        sha256 = "cca0847dad29beff57b36e21efd1a0c40f74781f4648fb0921fb269d4f61d583";
    };
};

in stdenv.mkDerivation {
    name = "qcustomplot-2.0.1";
    version = "2.0.1";

    src = srcs.qcustomplot_super;

    postUnpack = ''
        tar -xzf ${srcs.qcustomplot_sharedlib}
        mv qcustomplot-sharedlib qcustomplot-source/
    '';

    configurePhase = ''
        ( cd qcustomplot-sharedlib/sharedlib-compilation && qmake )
    '';
    buildPhase = ''
        ( cd qcustomplot-sharedlib/sharedlib-compilation && make -f Makefile.Release all )
    '';
    installPhase = ''
        mkdir -p $out/lib $out/include
        cp -rf qcustomplot-sharedlib/sharedlib-compilation/libqcustomplot.so* $out/lib/
        cp -rf qcustomplot.h $out/include/
    '';

    # Sets the build inputs, i.e. what will be available in our
    # local environment.
    buildInputs = [
        qt48Full
    ];
}
