This is a "clean" configuration setup for the laneslexicon application.

It should be extracted to the Resources directory.

In *nix and Windows this is a subdirectory of the directory in which the executable is found.

In OSX this is the Resources directory of the application bundle.


Extract one the lexicon.sqlite.7z or lexicon.sqlite.xz to get the uncompressed lexicon database.

| Item|   Description                                          |
|-------------|-------------------------------------|
|fonts |  contains freely distributable font files used by the application as defaults fonts
|themes/default| a full set of configuration files
|sitemap.ini   | used to load the corroect help page for inline documentation|
| history.sqlite | empty history database |
| notes.sqlite   | empty notes database |
| lexicon.sqlite.xz | a compressed lexicon database using xz compression utility|
| lexicon.sqlite.7zz | a compressed lexicon database using 7zz compression utility|
| config.ini | the top level configuration file |
