For an overview of the project see [here](http://laneslexicon.github.io).

This is a "clean" configuration setup for the laneslexicon application.

It should be extracted to the Resources directory.

In *nix and Windows this is a subdirectory of the directory in which the executable is found.

In OSX this is the Resources directory of the application bundle.

See [here](http://laneslexicon.github.io/lexicon/site/custom/themes/index.html) for a description of the required directory layout.


unzip lexicon.sqlite.zip to lexicon.sqlite in the Resources directory

| Item|   Description                                          |
|-------------|-------------------------------------|
| fonts |  contains freely distributable font files used by the application as defaults fonts |
| themes/default| a full set of configuration files |
| site         | the in program documentation      |
| sitemap.ini   | used to load the corroect help page for inline documentation|
| lexicon.sqlite.zip | a compressed lexicon database
| config.ini | the top level configuration file |
