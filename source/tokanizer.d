import std.stdio, std.string, std.array, std.format, std.regex, std.range, std.conv;

Regex!char[string] readLang(File languageFile){
    Regex!(char)[string] ret;
    int count = 0;

    foreach( line; languageFile.byLine(KeepTerminator.no)){
	string name, definition;
	formattedRead(line, "%s:%s", &name, &definition);
	writeln("name: ", name," -- definition: ", definition);
	ret[name] =  regex(definition);
	count++;
    }
    return ret;
}
