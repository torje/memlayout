import std.stdio, std.regex;
import tokanizer;

void main()
{
    import html;
    string[string] empty;
    auto b = readLang(File("view/lang", "r"));
    auto what = match("#include <asd>" , b["hashinclude"]);
    auto a = what.hit;
    writeln(a);
}
