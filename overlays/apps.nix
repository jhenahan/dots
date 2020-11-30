self:
super:
{
  installApplication =
    { name
    , appname ? name
    , version
    , src
    , description
    , homepage
    , postInstall ? ""
    , sourceRoot ? "."
    , ...
    }:
      with super;
      stdenv.mkDerivation {
        inherit src sourceRoot;
        name = "${name}-${version}";
        version = "${version}";
        buildInputs = [ undmg unzip ];
        phases = [
          "unpackPhase"
          "installPhase"
        ];
        installPhase = ''
          mkdir -p "$out/Applications/${appname}.app"
          cp -pR * "$out/Applications/${appname}.app"
        '' + postInstall;
        meta = with stdenv.lib;
          {
            inherit description homepage;
            platforms = platforms.darwin;
          };
      };
  Dash = self.installApplication rec {
    name = "Dash";
    version = "4.x";
    sourceRoot = "Dash.app";
    src = super.fetchurl {
      url = "https://kapeli.com/downloads/v4/Dash.zip";
      sha256 = "1dizd4mmmr3vrqa5x4pdbyy0g00d3d5y45dfrh95zcj5cscypdg2";
    };
    description = "Dash is an API Documentation Browser and Code Snippet Manager";
    homepage = "https://kapeli.com/dash";
  };
  Firefox = self.installApplication rec {
    name = "Firefox";
    version = "82.0.2";
    sourceRoot = "Firefox.app";
    src = super.fetchurl {
      name = "Firefox-${version}.dmg";
      url = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}/mac/en-US/Firefox%20${version}.dmg";
      sha256 = "1q0bp9a4cv3x8hcsknq2a7gm67jg61rppmxd913sdcr8709qydh9";
    };
    description = "Mozilla Firefox (or simply Firefox) is a free and open-source web browser.";
    homepage = "https://www.mozilla.org/en-US/firefox/";
  };
}
