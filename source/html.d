
private bool string_is_ascii( string str){	
	import std.algorithm, std.array, std.string, std.ascii;
	return all!( isAlphaNum)(str);
}
import std.functional;
private auto all(alias pred )(string[] list) 
//if ( is(typeof(unaryFun!pred(list.front))))
{
    import std.functional;
    auto alltrue = true;
    foreach(a; list){
	alltrue = alltrue && unaryFun!(pred)( a);
    }
    return alltrue;
}

string tag(string  arg, string[string] attributes, string contents){
    import  std.array, std.string, std.exception, std.format;	
    enforce( all!string_is_ascii( attributes.keys), " ----------------- ");
    auto ret = appender!string;
    formattedWrite( ret, `<%s`, arg );
    foreach(key, value; attributes){
	formattedWrite( ret, ` %s="%s"`, key , value );
    }
    formattedWrite( ret, ">\n", arg );
    if ( !contents.empty ){
	formattedWrite(ret, "%s\n", contents);
    }
    formattedWrite( ret, `</%s>`, arg );
    return ret.data;
}
unittest{
    //tag!( "p" )([   "class":"smalltext"		]);
     
       
    import std.exception, std.stdio; 
    try {
	enforce( all!string_is_ascii( [   "+":"a"		].keys), " ");
    } catch {
	writeln( "That threw");
    }
}
