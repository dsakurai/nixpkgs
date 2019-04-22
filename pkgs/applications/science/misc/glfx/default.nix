{stdenv, cmake, glew}:

# This avoids typing `pkgs.` before each package name.

# Defines a shell.
stdenv.mkDerivation {
    name = "glfx-0.0.20150113";
    nativeBuildInputs = [ cmake ];
    src = builtins.fetchGit {
        url = "https://github.com/maizensh/glfx.git";
        ref = "master";
        rev = "bf1cf05101298c44a78116391b78f58d8bbac914";
    };
    # Sets the build inputs, i.e. what will be available in our
    # local environment.
    buildInputs = [
#        qt48Full
#        log4cplus
#        gdal
#        hdf5
#        geos
        glew
#        freetype
#        grib-api
#        libGLU
#        gsl
    ];
}
