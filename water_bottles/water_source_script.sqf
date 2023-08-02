this setVariable ["currentWaterLevel", 20, true];
this setVariable ["maxWaterLevel", 20, true];

this addAction ["Check Water Level", {
    params[
        "_object", "_player",
        "_currentWaterLevel", "_maxWaterLevel"
    ];
    _object = _this select 3 select 0;
    _player = _this select 1;

    _currentWaterLevel = _object getVariable ["currentWaterLevel", 20];
    _maxWaterLevel = _object getVariable ["maxWaterLevel", 20];

    hint format ["The current water level is %1 out of %2", _currentWaterLevel, _maxWaterLevel];
    sleep 3;
    hintSilent "";
}, [this], 0, true, true, "", "", 10];

this addAction ["Refill Water Source", {
    params[
        "_object", "_player", 
        "_emptyBottle", "_emptyCanteen",
        "_filledBottle", "_filledCanteen",
        "_currentWaterLevel", "_maxWaterLevel"
    ];
    _object = _this select 3 select 0;
    _player = _this select 1;

    _emptyBottle = "ACE_WaterBottle_Empty";
    _filledBottle = "ACE_WaterBottle";
    _filledCanteen = "ACE_Canteen";
    _emptyCanteen = "ACE_Canteen_Empty";

    _currentWaterLevel = _object getVariable ["currentWaterLevel", 20];
    _maxWaterLevel = _object getVariable ["maxWaterLevel", 20];

    if(_currentWaterLevel == _maxWaterLevel) exitWith {
        hint format ["This water source is at the max capacity of %1", _maxWaterLevel];
        sleep 3;
        hintSilent "";
    };
    
    if(!isNull _player && {typeName _player == "OBJECT"}) then {
        _items = items _player;
        {
            if(_currentWaterLevel >= _maxWaterLevel) exitWith {
                hint "This water source is full, empty it using water containers.";
                sleep 3;
                hintSilent "";
            };

            if(_x isEqualTo _filledBottle) then {
                _player removeItem _x;
                _player addItem _emptyBottle;

                _currentWaterLevel = _currentWaterLevel + 1;
            } else {
                if (_x isEqualTo _filledCanteen) then {
                    _player removeItem _x;
                    _player addItem _emptyCanteen;

                    _currentWaterLevel = _currentWaterLevel + 1;
                }
            }
        } forEach _items;
        _object setVariable ["currentWaterLevel", _currentWaterLevel];

        hint format ["The current water level is %1 out of %2", _currentWaterLevel, _maxWaterLevel];
        sleep 3;
        hintSilent "";
    }
}, [this], 0, true, true, "", "", 10];

this addAction ["Fill Water Bottles", {
    params[
        "_object", "_player", 
        "_emptyBottle", "_halfBottle", "_filledBottle", 
        "_emptyCanteen", "_halfCanteen", "_filledCanteen", 
        "_bottlesFilled", "_currentWaterLevel"
    ];
    _object = _this select 3 select 0;
    _player = _this select 1;

    _emptyBottle = "ACE_WaterBottle_Empty";
    _halfBottle = "ACE_WaterBottle_Half";
    _filledBottle = "ACE_WaterBottle";
    _emptyCanteen = "ACE_Canteen_Empty";
    _halfCanteen = "ACE_Canteen_Half";
    _filledCanteen = "ACE_Canteen";

    _bottlesFilled = 0;
    _currentWaterLevel = _object getVariable ["currentWaterLevel", 5];

    if(_currentWaterLevel <= 0) exitWith {
        hint "This water source is empty, refill it using full water containers.";
        sleep 3;
        hintSilent "";
    };

    if(!isNull _player && {typeName _player == "OBJECT"}) then {
        _items = items _player;
        {
            if(_currentWaterLevel <= 0) exitWith {
                hint "This water source is empty, refill it using: --";
            };

            if(_x isEqualTo _emptyBottle || _x isEqualTo _halfBottle) then {
                _player removeItem _x;
                _player addItem _filledBottle;

                _bottlesFilled = _bottlesFilled + 1;
                _currentWaterLevel = _currentWaterLevel - 1;
            } else {
                if (_x isEqualTo _emptyCanteen || _x isEqualTo _halfCanteen) then {
                    _player removeItem _x;
                    _player addItem _filledCanteen;

                    _bottlesFilled = _bottlesFilled + 1;
                    _currentWaterLevel = _currentWaterLevel - 1;
                }
            }
        } forEach _items;
        _object setVariable ["currentWaterLevel", _currentWaterLevel];

        if(_bottlesFilled > 0) then {
            hint format["You have filled %1 of your bottles!", _bottlesFilled];
            sleep 3;
            hintSilent "";
            _bottlesFilled = 0;
        } else {
            hint "You have no bottles that need filling!";
            sleep 3;
            hintSilent "";
        }
    }
}, [this], 0, true, true, "", "", 10];