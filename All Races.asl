state("Cars", "EN")
{
	int inRace			: 0x3B5CE4, 0x10, 0x10, 0x10, 0x2D8,  0x14, 0xC, 0x8C;	// 0 on completion of Race, 1 during Race, 2 on Countdown, -1 in Hub World
	float segmentTime	: 0x3C63A4, 0x128, 0x10, 0x28;							// Time of current race in seconds
	bool loadScreen		: 0x3C38E8, 0x30, 0x4C;									// 1 whilst loading, else 0
}

state("Cars", "DK")
{
	int inRace			: 0x3B5CE4, 0x10, 0x10, 0x10, 0x2D8,  0x14, 0xC, 0x8C;
	float segmentTime	: 0x3C63A4, 0x128, 0x10, 0x28;
	int loadScreen		: 0x3C38E8, 0x30, 0x4C;
}

state("Cars", "FI")
{
	int inRace			: 0x3B5CE4, 0x10, 0x10, 0x10, 0x2D8,  0x14, 0xC, 0x8C;
	float segmentTime	: 0x3C63A4, 0x128, 0x10, 0x28;
	int loadScreen		: 0x3C38E8, 0x30, 0x4C;
}

state("Cars", "IT")
{
	int inRace			: 0x3B5CE4, 0x10, 0x10, 0x10, 0x2D8,  0x14, 0xC, 0x8C;
	float segmentTime	: 0x3C63A4, 0x128, 0x10, 0x28;
	int loadScreen		: 0x3C38E8, 0x30, 0x4C;
}

state("Cars", "NO")
{
	int inRace			: 0x3B5CE4, 0x10, 0x10, 0x10, 0x2D8,  0x14, 0xC, 0x8C;
	float segmentTime	: 0x3C63A4, 0x128, 0x10, 0x28;
	int loadScreen		: 0x3C38E8, 0x30, 0x4C;
}

state("Cars", "PL")
{
	int inRace			: 0x3B5CE4, 0x10, 0x10, 0x10, 0x2D8,  0x14, 0xC, 0x8C;
	float segmentTime	: 0x3C63A4, 0x128, 0x10, 0x28;
	int loadScreen		: 0x3C38E8, 0x30, 0x4C;
}

state("Cars", "SE")
{
	int inRace			: 0x3B5CE4, 0x10, 0x10, 0x10, 0x2D8,  0x14, 0xC, 0x8C;
	float segmentTime	: 0x3C63A4, 0x128, 0x10, 0x28;
	int loadScreen		: 0x3C38E8, 0x30, 0x4C;
}

state("Cars", "ES")
{
	int inRace			: 0x3B6EB4, 0x10, 0x10, 0x10, 0x2D8,  0x14, 0xC, 0x8C;
	float segmentTime	: 0x3C7574, 0x128, 0x10, 0x28;
	bool loadScreen		: 0x3C4AB8, 0x30, 0x4C;
}

state("Cars", "NL")
{
	int inRace			: 0x3B6EB4, 0x10, 0x10, 0x10, 0x2D8,  0x14, 0xC, 0x8C;
	float segmentTime	: 0x3C7574, 0x128, 0x10, 0x28;
	bool loadScreen		: 0x3C4AB8, 0x30, 0x4C;
}

state("Cars", "PT")
{
	int inRace			: 0x3B6EB4, 0x10, 0x10, 0x10, 0x2D8,  0x14, 0xC, 0x8C;
	float segmentTime	: 0x3C7574, 0x128, 0x10, 0x28;
	bool loadScreen		: 0x3C4AB8, 0x30, 0x4C;
}

state("Cars", "DE")
{
	int inRace			: 0x3B7E74, 0x10, 0x10, 0x10, 0x2D8,  0x14, 0xC, 0x8C;
	float segmentTime	: 0x3C8534, 0x128, 0x10, 0x28;
	bool loadScreen		: 0x3C5A78, 0x30, 0x4C;
}

state("Cars", "FR")
{
	int inRace			: 0x3B6CE4, 0x10, 0x10, 0x10, 0x2D8,  0x14, 0xC, 0x8C;
	float segmentTime	: 0x3C73A4, 0x128, 0x10, 0x28;
	bool loadScreen		: 0x3C48E8, 0x30, 0x4C;
}

state("Cars", "SU")
{
	int inRace			: 0x3B6CE4, 0x10, 0x10, 0x10, 0x2D8,  0x14, 0xC, 0x8C;
	float segmentTime	: 0x3C73A4, 0x128, 0x10, 0x28;
	bool loadScreen		: 0x3C48E8, 0x30, 0x4C;
}

startup
{
	refreshRate = 30;		// Category uses IGT, refreshRate can be reduced without consequence. Splitter will look laggy, but still be accurate.
}

init
{
	vars.hasSplit = false;
	vars.doSplit = false;
	
	// Version checking.
	print("ModuleMemorySize: " + modules.First().ModuleMemorySize.ToString());	// Lets DebugView show the ModuleMemorySize of the executable
	byte[] exeMD5HashBytes = new byte[0];
	using (var md5 = System.Security.Cryptography.MD5.Create())
	{
		using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
		{
			exeMD5HashBytes = md5.ComputeHash(s); 
		} 
	}
	var MD5Hash = exeMD5HashBytes.Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
	print("MD5Hash: " + MD5Hash.ToString()); 				// Lets DebugView show the MD5Hash of theexecutable

	switch (MD5Hash.ToString())								//Sets the state descriptor for the correct game version
	{
		case "7BC85EB15381F4D96124965D7E232209":	version = "EN";		break;	// English exe
		case "25DC2E03A49C23201D62FF5CAA677E8B":	version = "DK";		break;	// Danish exe
		case "FAC76F0BE2A8B20294C7EED2C1072AA4":	version = "FI";		break;	// Finnish exe
		case "57EC8EADD0B33CF2395F7B17E411B1A8":	version = "IT";		break;	// Italian exe
		case "6A27C7C8108D25EF7B39AEE75825B942": 	version = "NO";		break;	// Norweigan exe
		case "A5481EB0D517A84D170293B1C08A13EF":	version = "PL";		break;	// Polish exe
		case "8845F0ECABCF98A6B6852BB7B94A8E19":	version = "SE";		break;	// Swedish exe
		case "39F39FECF11FCAB959818968F6144478": 	version = "ES";		break;	// Spanish exe
		case "258264302FEC29B1626FECE9CE61C787": 	version = "NL";		break;	// Dutch exe
		case "11742131039810613299C44D424FCA8F":	version = "PT";		break;	// Portuguese exe
		case "B07888CFB1B6760FBC5F6C5E0642938F":	version = "DE";		break;	// German exe
		case "A170ADB5508F8E0EA331707AA5369826":	version = "FR";		break;	// French exe
		case "937AB1102AF423CE8C6F3166F1EBE317":	version = "SU";		break;	// steamunlocked
	}
}

start
{
	if (current.inRace == 2 && old.inRace != 2)
	{
		vars.runTime = 0f;
		return true;
	}
}

update
{
	if (current.loadScreen)
	{
		vars.hasSplit = false;
	}
}

split
{
	if(vars.doSplit)
	{
		vars.doSplit = false;
		if(current.inRace == 0 && current.segmentTime != 0 &! current.loadScreen)
		{
			vars.runTime += Math.Round(old.segmentTime,2);		// Keeps cumulative total of all individual races.
			vars.hasSplit = true;								// Prevent double splits
			return true;
		}
	}
	else if(current.segmentTime == old.segmentTime && current.segmentTime != 0 && current.inRace == 0 &! vars.hasSplit)			// Splits on the frame the race timer stops (you cross the line) in races
	{
		vars.doSplit = true;
		Thread.Sleep(100);			// Delays split check to prevent splits on "Restart Event" and "Switch Event"
	}
}

gameTime
{
	if(vars.hasSplit)
	{
		return TimeSpan.FromSeconds(vars.runTime);
	}
	else
	{
	return TimeSpan.FromSeconds(vars.runTime + (Math.Round(current.segmentTime,2)));	// Rounds to same precision as game (2 d.p.)
	}
}

isLoading
{
	return true;
}