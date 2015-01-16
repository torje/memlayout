import std.stdio, std.format, std.conv, std.string, std.array, std.typecons, std.exception, std.range;

struct bnfchoice{
    Nullable!(string[])  rulesplit;
    invariant(){
	enforce( !rulesplit.isNull(), "Go die!");
    }
    this(string description){
	rulesplit = description.split("|");
    }
    string toString(){
	return rulesplit.to!string;
    }
}
struct bnfchain{
    Nullable!(bnfchoice[]) rules;
    invariant(){
	enforce( !rules.isNull(), "Go die!");
    }
    this( string ruleline){
	rules = [];
	foreach(  word;ruleline.split(" ")){
	    rules ~= bnfchoice( word);
	}
    }
    string toString(){
	return rules.to!string;
    }
    
}

struct language{
    /+struct regex_name{
	string madefrom;
	Regex!char regex;
    }+/
    
    //alias regex_name = Tuple!( Regex!char,"regex", string, "madefrom");
    import std.regex;
    bnfchain[string] rules;
    //regex_name[string] regex_rules;
    Regex!char[string] regex_rules;
    this( string composites, string regexes){
	foreach( line; composites.splitLines()){
	    string rulename;
	    formattedRead(line, "%s: ", &rulename);
	    auto rule = bnfchain( line);
	    rules[rulename] = rule;
	}
	foreach( line; regexes.splitLines){
	    string rulename;
	    formattedRead( line, "%s: ", &rulename);
	    auto rule = regex( "^\\s" ~ line);
	    regex_rules[rulename] = rule;
	    //regex_rules[rulename].madefrom = line;
	}
    }
    string toString(){
	string[] arr;
	foreach( key, value; rules){
	    auto ret = appender!string;
	    formattedWrite(ret , "%s =:: %s", key, value);
	    arr ~= ret.data;
	}

	foreach( key, value; regex_rules){
	    auto ret = appender!string;
	    formattedWrite(ret , "%s", key);
	    arr ~= ret.data;
	}
	return arr.join("\n");
    }
}

unittest{
    {
	auto a = bnfchoice( "frompath|fromlocal");
	auto b = bnfchoice("linebreak");
	auto c = bnfchoice("");
	writeln(a);
	writeln(b);
	writeln(c);
    }
    {
	auto a = bnfchain("hashinclude frompath|fromlocal linebreak");
	writeln( a);
    }
    {
	import std.file;
	auto regexes = readText( "/home/torje/source/gallery/view/lang");
	auto rules = readText( "/home/torje/source/gallery/view/combines");
	auto a = language( rules, regexes);
	writeln(a);
    }
}
