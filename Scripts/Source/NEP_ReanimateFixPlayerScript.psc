Scriptname NEP_ReanimateFixPlayerScript extends ReferenceAlias
{Player script.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

NEP_ReanimateFixInitScript Property NEP_ReanimateFix Auto
{Reanimate Fix Quest script.}

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnPlayerLoadGame()

  NEP_ReanimateFix.AddReanimateFixPerk()

EndEvent
