--- Client job module.
-- Client player job control and receiving module.
-- @module cl_role.lua

local function ReceiveJobPreferenceRequest()
	T.LogMsgN( "Job preference request received.", 2 )
	T.JobPref.Show()
end
net.Receive( T.NET.JOB_PREF, ReceiveJobPreferenceRequest )
