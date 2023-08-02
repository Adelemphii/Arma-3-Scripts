this addAction ["Fill Water Bottles", { 
    params[ 
        "_player",  
        "_emptyBottle", "_halfBottle", "_filledBottle",  
        "_emptyCanteen", "_halfCanteen", "_filledCanteen", 
        "_bottlesFilled" 
      ]; 
    _player = _this select 1; 
 
    _emptyBottle = "ACE_WaterBottle_Empty"; 
    _halfBottle = "ACE_WaterBottle_Half"; 
    _filledBottle = "ACE_WaterBottle"; 
    _emptyCanteen = "ACE_Canteen_Empty"; 
    _halfCanteen = "ACE_Canteen_Half"; 
    _filledCanteen = "ACE_Canteen"; 
 
    _bottlesFilled = 0;
 
    if (!isNull _player && {typeName _player == "OBJECT"}) then { 
        _items = items _player; 
        { 
            if (_x isEqualTo _emptyBottle || _x isEqualTo _halfBottle) then { 
                _player removeItem _x; 
                _player addItem _filledBottle; 

                _bottlesFilled = _bottlesFilled + 1;
            } else { 
                if (_x isEqualTo _emptyCanteen || _x isEqualTo _halfCanteen) then { 
                    _player removeItem _x; 
                    _player addItem _filledCanteen; 

                    _bottlesFilled = _bottlesFilled + 1;
                }
            }
        } forEach _items; 
        
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
}, [], -1, true, true, "", ""];