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

-- Generic job
local JOB = {
	name = "Generic Job",
	description = "A generic job.",
	faction = "station",
	department = "civilian",
	supervisor = "head_of_personel",
	access = { }
}
job.Register( "GenericJob", JOB )

-- Assistant
local JOB = {
	name = "Assistant",
	description = "",
	faction = "station",
	department = "civilian",
	supervisor = "head_of_personel",
	access = { }
}
job.Register( "Assistant", JOB )
