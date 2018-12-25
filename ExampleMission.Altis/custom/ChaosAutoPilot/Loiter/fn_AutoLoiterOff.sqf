_unit = _this select 0;

_veh = vehicle _unit;
_veh deleteVehicleCrew _unit;

//can be used to let other people take over the pilot seat from the bot
_veh setVariable ["ChaosPilot_PilotUnit", nil, true]; //#TODO maybe broadcast global???
_veh setVariable ["ChaosPilot_PreviousOwner", nil, true]; //#TODO maybe broadcast global???
_veh setVariable ["ChaosPilot_AutoPilotOn", nil, true]; //#TODO maybe broadcast global???

if (count _this > 1) then
{
	_player = _this select 1;
	moveOut _player;
	_player moveInDriver _veh; 
};


//_groupveh = group _veh;
/* while {(count (waypoints _groupveh)) > 0} do
{
	deleteWaypoint ((waypoints _groupveh) select 0);
}; */
//_groupveh addWaypoint [getPos _veh, 0];


_veh enableCopilot true;

ChaosPilot_LoiterInfoTemp = [-1,-1,-1];
ChaosPilot_LoiterInfo set [0, [-1,-1,-1]];