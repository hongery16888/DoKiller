-- Generated from template


require 'utils.table'
require 'api.CDOTAPlayer'

require 'modules.round_manager'

function Activate( )

	GameRules.vAllPlayers = {}

	require 'utils.funcs'
end

function Precache(context)
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
end