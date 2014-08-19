--[[
Job table structure:

Key: "name"
Value: string name for the job

Key: "description"
Value: string description for the job

Key: "department"
Value: string identifier of the job department; acceptable values: "command", "security",
"engineering", "science", "medical", "supply", "service", "civilian", "misc"

Key: "departmentTier"
Value: tier in the department, entirely for sorting purposes.

Key: "faction"
Value: string identifier of the default job faction; most commonly "station", less commonly
"neutral", but can be a unique identifier like "terrorist", "alien", etc.

Key: "access"
Value: table of area access identifiers (e.g. "security", "science", "medical", "storage", etc.)
--]]

job.Jobs = {}

-- Register a job.
-- @param jobKey Class name of job to create.
-- @param jobTable Table containing the job information.
function job.Register( jobKey, jobTable )
	if ( not job.Jobs[ jobKey ] ) then
		job.Jobs[ jobKey ] = {}
		job.Jobs[ jobKey ].title = jobTable.title
		job.Jobs[ jobKey ].description = jobTable.description
		job.Jobs[ jobKey ].faction = jobTable.faction
		job.Jobs[ jobKey ].department = jobTable.department
		job.Jobs[ jobKey ].departmentTier = jobTable.departmentTier
		job.Jobs[ jobKey ].supervisor = jobTable.supervisor
		job.Jobs[ jobKey ].access = table.Copy( jobTable.access )
	else
		log.MsgN( Format( "Job \"%s\" already registered.", name ), 2 )
	end
end

function job.GetJobsTable()
	return table.Copy( job.Jobs )
end

-- COMMAND

job.Register( "Captain", {
	title = "Captain",
	description = "Govern the station and heads of staff.",
	faction = "Station",
	department = "Command",
	departmentTier = 1,
	supervisor = "Corporation officials and space law",
	access = {}
} )

job.Register( "HeadOfPersonnel", {
	title = "Head of Personnel",
	description = "See to access changes, watch over Supply and Service departments, and deal with internal affairs.",
	faction = "Station",
	department = "Command",
	departmentTier = 2,
	supervisor = "Captain and Space Law",
	access = {}
} )

-- SECURITY

job.Register( "HeadOfSecurity", {
	title = "Head of Security",
	description = "Oversee the Security team and keep the station safe.",
	faction = "Station",
	department = "Security",
	departmentTier = 1,
	supervisor = "Captain and Space Law.",
	access = {}
} )

job.Register( "Warden", {
	title = "Warden",
	description = "Watch over the brig and make sure the prisoners are treated fairly.",
	faction = "Station",
	department = "Security",
	departmentTier = 2,
	supervisor = "Head of Security and Space Law",
	access = {}
} )

job.Register( "SecurityOfficer", {
	title = "Security Officer",
	description = "Keep the crew safe and secure.",
	faction = "Station",
	department = "Security",
	departmentTier = 3,
	supervisor = "Head of Security and Space Law",
	access = {}
} )

job.Register( "Detective", {
	title = "Detective",
	description = "Investigate crimes, gather evidence, smoke cigarettes.",
	faction = "Station",
	department = "Security",
	departmentTier = 4,
	supervisor = "Head of Security and Space Law",
	access = {}
} )

-- ENGINEERING

job.Register( "ChiefEngineer", {
	title = "Chief Engineer",
	description = "Maintain the engineering crew. Fix the station.",
	faction = "Station",
	department = "Engineering",
	departmentTier = 1,
	supervisor = "Captain",
	access = {}
} )

job.Register( "StationEngineer", {
	title = "Station Engineer",
	description = "Set up the engine and maintain the station.",
	faction = "Station",
	department = "Engineering",
	departmentTier = 2,
	supervisor = "Chief Engineer",
	access = {}
} )

job.Register( "AtmosphericTechnician", {
	title = "Atmospheric Technician",
	description = "Oversee the atmospherics machines and disposals system.",
	faction = "Station",
	department = "Engineering",
	departmentTier = 3,
	supervisor = "Chief Engineer",
	access = {}
} )

-- SCIENCE

job.Register( "ResearchDirector", {
	title = "Research Director",
	description = "Manage the Science team and ensure that research is being done.",
	faction = "Station",
	department = "Science",
	departmentTier = 1,
	supervisor = "Captain",
	access = {}
} )

job.Register( "Scientist", {
	title = "Scientist",
	description = "Preform various research and science tasks.",
	faction = "Station",
	department = "Science",
	departmentTier = 2,
	supervisor = "Research Director",
	access = {}
} )

job.Register( "Roboticist", {
	title = "Roboticist",
	description = "Build and manage mechs, robots, silicons, and the AI.",
	faction = "Station",
	department = "Science",
	departmentTier = 3,
	supervisor = "Research Director",
	access = {}
} )

-- MEDICAL

job.Register( "ChiefMedicalOfficer", {
	title = "Chief Medical Officer",
	description = "Regulate the medical team and pet Runtime.",
	faction = "Station",
	department = "Medical",
	departmentTier = 1,
	supervisor = "Captain",
	access = {}
} )

job.Register( "MedicalDoctor", {
	title = "Medical Doctor",
	description = "Keep the crew healthy.",
	faction = "Station",
	department = "Medical",
	departmentTier = 2,
	supervisor = "Chief Medical Officer",
	access = {}
} )

job.Register( "Chemist", {
	title = "Chemist",
	description = "Mix chemicals to create different drugs.",
	faction = "Station",
	department = "Medical",
	departmentTier = 3,
	supervisor = "Chief Medical Officer",
	access = {}
} )

job.Register( "Geneticist", {
	title = "Geneticist",
	description = "Study genes and clone the crew when they die.",
	faction = "Station",
	department = "Medical",
	departmentTier = 4,
	supervisor = "Chief Medical Officer, Research Director",
	access = {}
} )

job.Register( "Virologist", {
	title = "Virologist",
	description = "Cure and create space diseases .",
	faction = "Station",
	department = "Medical",
	departmentTier = 5,
	supervisor = "Chief Medical Officer",
	access = {}
} )

-- SUPPLY

job.Register( "Quartermaster", {
	title = "Quartermaster",
	description = "Lord of Cargo Bay, manage the Cargo Techs and Shaft Miners.",
	faction = "Station",
	department = "Supply",
	departmentTier = 1,
	supervisor = "Head of Personnel",
	access = {}
} )

job.Register( "CargoTechnician", {
	title = "Cargo Technician",
	description = "Move crates around, be comfortable in shorts, and order crates for the crew.",
	faction = "Station",
	department = "Supply",
	departmentTier = 2,
	supervisor = "Quartermaster, Head of Personnel",
	access = {}
} )

job.Register( "ShaftMiner", {
	title = "Shaft Miner",
	description = "Mine the asteroid for the coveted plasma and other materials.",
	faction = "Station",
	department = "Supply",
	departmentTier = 3,
	supervisor = "Quartermaster, Head of Personnel",
	access = {}
} )

-- SERVICE

job.Register( "Janitor", {
	title = "Janitor",
	description = "Protector of a clean station, wielder of the mop.",
	faction = "Station",
	department = "Service",
	departmentTier = 1,
	supervisor = "Head Of Personnel",
	access = {}
} )

job.Register( "Bartender", {
	title = "Bartender",
	description = "Mix and serve drinks to the crew.",
	faction = "Station",
	department = "Service",
	departmentTier = 2,
	supervisor = "Head of Personnel",
	access = {}
} )

job.Register( "Chef", {
	title = "Chef",
	description = "Cook food and keep the crew full.",
	faction = "Station",
	department = "Service",
	departmentTier = 3,
	supervisor = "Head of Personnel",
	access = {}
} )

job.Register( "Botanist", {
	title = "Botanist",
	description = "Grow plants for the chef, and mutate them for your own amusement.",
	faction = "Station",
	department = "Service",
	departmentTier = 4,
	supervisor = "Head of Personnel",
	access = {}
} )

-- MISCELLANEOUS

job.Register( "Assistant", {
	title = "Assistant",
	description = "Wander the station looking to help other people.",
	faction = "Station",
	department = "Civilian",
	departmentTier = 1,
	supervisor = "Anyone",
	access = {}
} )

job.Register( "Clown", {
	title = "Clown",
	description = "Entertain the crew with funny jokes and pranks.",
	faction = "Station",
	department = "Civilian",
	departmentTier = 2,
	supervisor = "Head of Personnel",
	access = {}
} )

job.Register( "Mime", {
	title = "Mime",
	description = "...",
	faction = "Station",
	department = "Civilian",
	departmentTier = 3,
	supervisor = "Head of Personnel",
	access = {}
} )

job.Register( "Chaplain", {
	title = "Chaplain",
	description = "Preach to the crew about your deity and spread awareness of your religion.",
	faction = "Station",
	department = "Civilian",
	departmentTier = 4,
	supervisor = "Head of Personnel",
	access = {}
} )

job.Register( "Librarian", {
	title = "Librarian",
	description = "Stock the library with books and have story time.",
	faction = "Station",
	department = "Civilian",
	departmentTier = 5,
	supervisor = "Head of Personnel",
	access = {}
} )

job.Register( "Lawyer", {
	title = "Lawyer",
	description = "Make sure prisoners have their rights upheld by Security.",
	faction = "Station",
	department = "Civilian",
	departmentTier = 6,
	supervisor = "Head of Personnel",
	access = {}
} )
