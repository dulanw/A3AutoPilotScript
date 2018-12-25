#include "..\AutoPilotConfig.h"

_CanOn = player call ChaosPilot_fnc_CanOnAutoLoiter;
hint format["%1", _CanOn];
if (_CanOn == 0) then
{
	_veh = vehicle player;
	_AutoPilotOn = _veh getVariable ["ChaosPilot_AutoPilotOn",false];
	if (ChaosPilot_LoiterInfoTemp isEqualTo [-1,-1,-1] && !_AutoPilotOn) then
	{
		hint "please select a target location";
	}
	else
	{
		_Pos = ChaosPilot_LoiterInfoTemp; 
	
		_RadiusIndex = lbCurSel 3100;
		
		_HeightIndex = lbCurSel 3101;
		
		_SideIndex = lbCurSel 3102;
			
		if (_AutoPilotOn) then
		{
			_Pos = ChaosPilot_LoiterInfo select 0; //get the current loiter position before deleting
			player call ChaosPilot_fnc_AutoLoiterOff;
			
		};
		
		_unit = [_Pos, _RadiusIndex, _HeightIndex, _SideIndex] call ChaosPilot_fnc_AutoLoiterOn;
		if (!isNull _unit) then
		{
			_veh = vehicle _unit;
			//hint format["vehicle %1 %2", _veh, group _unit];
			waitUntil { _unit == driver _veh; };
			vehicle _unit engineOn true;
			_veh setEngineRPMRTD [9000, -1];
			
			ChaosPilot_LoiterInfo set [0, _Pos];
			ChaosPilot_LoiterInfo set [1, _RadiusIndex];
			ChaosPilot_LoiterInfo set [2, _HeightIndex];
			ChaosPilot_LoiterInfo set [3, _SideIndex];
		};
	};
}
else
{
	switch (_CanOn) do
	{
		case 1 : { hint "Must be inside a plane"; };
		case 2 : { hint "Only the pilot may activate AutoPilot"; };
		case 3 : { hint format["Minimum speed of %1 required", MINIMUM_SPEED]; };
		case 4 : { hint format["Minimum altitude of %1 required", MINIMUM_HEIGHT_ASL]; }; 
		case 5 : { hint "Only the previous pilot can set target"; };
		default {hint "unknown error"; };
	};
};