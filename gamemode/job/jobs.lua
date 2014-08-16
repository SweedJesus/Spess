--- A generic job.

--[[
Job table structure:

Key: "name"
Value: string name for the job

Key: "description"
Value: string description for the job

Key: "department"
Value: string identifier of the job department; acceptable values: "command", "security",
"engineering", "science", "medical", "supply", "service", "civilian", "misc"

Key: "faction"
Value: string identifier of the default job faction; most commonly "station", less commonly
"neutral", but can be a unique identifier like "terrorist", "alien", etc.

Key: "access"
Value: table of area access identifiers (e.g. "security", "science", "medical", "storage", etc.)
--]]

-- Blank job
-- job.Register( "", {
-- 	name = "",
-- 	description = "",
-- 	faction = "",
-- 	department = "",
-- 	supervisor = "",
-- 	access = { }
-- } )

-- COMMAND

job.Register( "Captain", {
	name = "Captain",
	description = "Manage the station and heads of staff.",
	faction = "Station",
	department = "Command",
	supervisor = "Corporation officials and space law",
	access = { }
} )

job.Register( "HeadOfPersonnel", {
	name = "Head of Personnel",
	description = "",
	faction = "Station",
	department = "Command",
	supervisor = "",
	access = { }
} )

-- SECURITY

job.Register( "HeadOfSecurity", {
	name = "Head of Security",
	description = "",
	faction = "Station",
	department = "Security",
	supervisor = "",
	access = { }
} )

job.Register( "Warden", {
	name = "Warden",
	description = "",
	faction = "Station",
	department = "Security",
	supervisor = "",
	access = { }
} )

job.Register( "SecurityOfficer", {
	name = "Security Officer",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

job.Register( "Detective", {
	name = "Detective",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

-- ENGINEERING

job.Register( "ChiefEngineer", {
	name = "Chief Engineer",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

job.Register( "StationEngineer", {
	name = "Station Engineer",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

job.Register( "AtmosphericTechnician", {
	name = "Atmospheric Technician",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

-- SCIENCE

job.Register( "ResearchDirector", {
	name = "Research Director",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

job.Register( "Scientist", {
	name = "Scientist",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

job.Register( "Roboticist", {
	name = "Roboticist",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

-- MEDICAL

job.Register( "ChiefMedicalOfficer", {
	name = "Chief Medical Officer",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

job.Register( "MedicalDoctor", {
	name = "Medical Doctor",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

job.Register( "Chemist", {
	name = "Chemist",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

job.Register( "Geneticist", {
	name = "Geneticist",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

job.Register( "Virologist", {
	name = "Virologist",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

-- SUPPLY

job.Register( "Quartermaster", {
	name = "Quartermaster",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

job.Register( "CargoTechnician", {
	name = "Cargo Technician",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

job.Register( "ShaftMiner", {
	name = "Shaft Miner",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

-- SERVICE

job.Register( "Janitor", {
	name = "Janitor",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

job.Register( "Bartender", {
	name = "Bartender",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

job.Register( "Chef", {
	name = "Chef",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

job.Register( "Botanist", {
	name = "Botanist",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

-- MISCELLANEOUS

job.Register( "Assistant", {
	name = "Assistant",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

job.Register( "Clown", {
	name = "Clown",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

job.Register( "Mime", {
	name = "Mime",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

job.Register( "Chaplain", {
	name = "Chaplain",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

job.Register( "Librarian", {
	name = "Librarian",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )

job.Register( "Lawyer", {
	name = "Lawyer",
	description = "",
	faction = "",
	department = "",
	supervisor = "",
	access = { }
} )
