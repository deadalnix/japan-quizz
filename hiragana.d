module hiragana;

import std.algorithm;
import std.range;
import std.stdio;
import std.string;
import std.typecons;

immutable string[string] hiragana2romanji;

shared static this() {
	hiragana2romanji = [
		"あ"	: "a",	"か"	: "ka",	"さ"	: "sa",		"た"	: "ta",		"な"	: "na",	"は"	: "ha",	"ま"	: "ma",	"や"	: "ya",	"ら"	: "ra",	"わ"	: "wa",
		"い"	: "i",	"き"	: "ki", "し"	: "shi",	"ち"	: "chi",	"に"	: "ni",	"ひ"	: "hi",	"み"	: "mi",					"り"	: "ri",	"ゐ"	: "wi",
		"う"	: "u",	"く"	: "ku",	"す"	: "su",		"つ"	: "tsu",	"ぬ"	: "nu",	"ふ"	: "fu",	"む"	: "mu",	"ゆ"	: "yu",	"る"	: "ru",
		"え"	: "e",	"け"	: "ke",	"せ"	: "se",		"て"	: "te",		"ね"	: "ne",	"へ"	: "he",	"め"	: "me",					"れ"	: "re",	"ゑ"	: "we",
		"お"	: "o",	"こ"	: "ko",	"そ"	: "so",		"と"	: "to",		"の"	: "no",	"ほ"	: "ho",	"も"	: "mo",	"よ"	: "yo",	"ろ"	: "ro",	"を"	: "wo",
		"ん"	: "n",
	];
}

void main() {
	import std.random, std.datetime;
	auto gen = Mt19937(cast(uint) Clock.currStdTime());
	
	uint combo;
	
	while(true) {
		Tuple!(string, string)[] entries, messed;
		foreach(k; hiragana2romanji.byKey) {
			string dmdsux = hiragana2romanji[k];
			entries ~= tuple(k, dmdsux);
		}
		
		messed.reserve(entries.length);	
		while(entries.length) {
			gen.popFront();
			
			auto i = gen.front % entries.length;
			messed ~= entries[i];
			
			auto remains = entries[i + 1 .. $];
			
			entries = entries[0 .. i];
			entries.assumeSafeAppend();
			
			entries ~= remains;
		}
		
		foreach(e; messed) {
			auto hira = e[0];
			auto roman = e[1];
			
			write(hira, "\t: ");
			auto answer = readln();
			
			combo++;
			if(answer.strip() == roman) {
				writeln("Right ! That is ", combo, " in a row !");
			} else {
				writeln("Wrong ! The right answer was ", roman);
				combo = 0;
			}
		}
	}
}

