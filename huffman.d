module huffman.d;
import std.stdio;
import std.conv;
import std.algorithm;
import std.string;
import std.math;
struct HuffmanTree
{
	private
	{
		uint[string] compressTable_;
		string[uint] decompressTable_;
		Node top_;
		File fileToCompress_;
		File compressedFile_;
		string fileName_;
	}

	public this(string fileName)
	{
		fileToCompress_.open(fileName ~ ".had", "r");
		compressedFile_.open(fileName ~ "compressed" ~ ".had", "w");
		fileName_ = fileName ~ ".txt";
	}

	~this()
	{
		auto tables = File("tables.had", "w");
		tables.writeln(compressTable_);
		tables.writeln(decompressTable_);
		fileToCompress_.close();
		compressedFile_.close();
	}

	public void setTables(Node top)
	{
		compressTable_ = top_.returnTable;
		foreach(key, value; compressTable_){
			decompressTable_[value] = key;
		}
	}

	public void compressFile()
	{
		string lines;
		while(!fileToCompress_.eof()){
			lines ~= fileToCompress_.readln();
		}
		auto nodes = searchLetters(lines);
		top_ = createTree(nodes);
		top_.setBinaryCodes();
		setTables(top_);
		string compressedText;
		foreach(letter; lines){
			compressedText ~= format("%b", compressTable_[to!string(letter)]);
			if(compressedText.length >= 8){
				compressedFile_.rawWrite([toDecimal(compressedText[0 .. 8])]);
				compressedText = compressedText[8 .. $];
			}
		}
		compressedFile_.rawWrite([toDecimal(compressedText[0 .. $])]);
	}
}

ubyte toDecimal(string number)
in
{
    assert(number.length != 0);
}
body
{
    ubyte result;
 
    foreach (i; 0 .. number.length) {
        if (number[i] == '1') {
            result += 2 ^^ (number.length - 1 - i);
        }
    }
 
    return result;
}

struct Node
{
	private
	{
		string value_;
		uint binaryCode_;
		uint frequency_;
		Node* right_;
		Node* left_;
	}

	public this(const uint frequence, string value)
	{
		value_ = value;
		frequency_ = frequence;
	}

	public int opCmp(Node another) const
	{
		return frequency_ == another.frequency_ ? cmp(value_, another.value_) : frequency_ - another.frequency_ ;
	}

	public string toString() const
	{
		string result;
		result ~= "Binary code: " ~ to!string(binaryCode_) ~ "\n";
		result ~= "Letter: " ~ value_ ~ "\n";
		return result;
	}

	public void setBinaryCodes()
	{
		if(right_ && left_)
		{
			right_.binaryCode_ = binaryCode_;
			left_.binaryCode_ = binaryCode_;
			right_.binaryCode_ <<= 1;
			left_.binaryCode_ <<= 1;
			right_.binaryCode_ |= 1;
			right_.setBinaryCodes();
			left_.setBinaryCodes();
		}
	}

	public uint[string] returnTable() const @property
	{ 
		uint[string] result;
		result[value_] = binaryCode_;
		if(right_ && left_)
		{
			foreach(index, value; left_.returnTable()){
				if(index.length==1){
				    result[index] = value;	
				} 
			}
			foreach(index, value; right_.returnTable()){
				if(index.length==1){
					result[index] = value;
				} 
			}
		}
		foreach(index, value; result){
			if(index.length != 1){
				result.remove(index);
			}
		}
		return result;
	}
}

Node[] searchLetters(string text)
{
	uint[char] letters;
	Node[] result;
	foreach(character; text){
		if(character in letters){
		    ++letters[character];
		} else {
			letters[character] = 1;
		}
	}
	foreach(index, value; letters){
		result ~= Node(value, to!string(index));
	}
	return result;
}

Node createTree(Node[] nodes)
{
	while(nodes.length > 1)
	{
		nodes.sort();
		auto newNode = Node((nodes[0].frequency_ + nodes[1].frequency_), (nodes[0].value_ ~ nodes[1].value_));
		newNode.left_ = &nodes[0];
		newNode.right_ = &nodes[1];
		nodes ~= newNode;
		nodes = nodes[2 .. $];
	}
	return nodes[0];
}

