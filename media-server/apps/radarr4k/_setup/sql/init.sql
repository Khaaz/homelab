-- Clean the table (delete all rows)
DELETE FROM NamingConfig;

-- Insert the new data
INSERT INTO NamingConfig (
    Id, 
    ReplaceIllegalCharacters, 
    StandardMovieFormat, 
    MovieFolderFormat, 
    ColonReplacementFormat, 
    RenameMovies
)
VALUES (
    1, 
    1, 
    '{Movie CleanTitle} {(Release Year)} {tmdb-{TmdbId}} {edition-{Edition Tags}} {[Custom Formats]}{[Quality Full]}{[MediaInfo 3D]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[Mediainfo VideoCodec]}{-Release Group}', 
    '{Movie CleanTitle} ({Release Year}) {tmdb-{TmdbId}}', 
    4, 
    1
);