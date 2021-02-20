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
    version = "5.x";
    sourceRoot = "Dash.app";
    src = super.fetchurl {
      url = "https://kapeli.com/downloads/v5/Dash.zip";
      sha256 = "sha256-u3fdO3BEpQw2LONxE0F4ytRzdjH9fksaEyYEErJ4/UE=";
    };
    description = "Dash is an API Documentation Browser and Code Snippet Manager";
    homepage = "https://kapeli.com/dash";
  };
  Firefox = self.installApplication rec {
    name = "Firefox";
    version = "85.0.1";
    sourceRoot = "Firefox.app";
    src = super.fetchurl {
      name = "Firefox-${version}.dmg";
      url = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}/mac/en-US/Firefox%20${version}.dmg";
      sha256 = "0b339j9yg5mjmlf7pgjcsrhchzllxns31vlbzndyadq7bpqs73kj";
    };
    description = "Mozilla Firefox (or simply Firefox) is a free and open-source web browser.";
    homepage = "https://www.mozilla.org/en-US/firefox/";
  };
}
