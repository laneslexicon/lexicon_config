For an overview of the project see [here](http://laneslexicon.github.io).


This is a "clean" configuration setup for the laneslexicon application; it contains the lexicon database as well as fonts,images, and assorted configuration files.

If you simply wish to download a new database i.e. the Lexicon itself, double-click on "lexicon.sqlite.zip" and then on the "Download button".

The application requires the content of this repository to be in a directory named "Resources".

In *nix and Windows this is a subdirectory of the directory in which the executable is found.

In OSX/macOS this is the Resources directory of the application bundle.

See [here](http://laneslexicon.github.io/lexicon/site/custom/themes/index.html) for a description of the required directory layout.

After placing the contents in the Resources directory, unzip "lexicon.sqlite.zip" to create "lexicon.sqlite".

The top-level files are folders are:

| Item|   Description                                          |
|-------------|-------------------------------------|
| fonts |  contains freely distributable font files used by the application as defaults fonts |
| themes/default| a full set of configuration files |
| site         | the in program documentation      |
| sitemap.ini   | used to load the corroect help page for inline documentation|
| lexicon.sqlite.zip | a compressed lexicon database
| config.ini | the top level configuration file |
