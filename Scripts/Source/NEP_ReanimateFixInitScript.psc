Scriptname NEP_ReanimateFixInitScript extends Quest
{Initialization script for reanimate fix quest.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Actor Property PlayerRef Auto
{The player.}

Perk Property NEP_ReanimateFixPerk Auto
{Perk that applies entry point for reanimate effect fix.}

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function AddReanimateFixPerk()

  If !PlayerRef.HasPerk(NEP_ReanimateFixPerk)
    PlayerRef.AddPerk(NEP_ReanimateFixPerk)
  EndIf

EndFunction

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnInit()

  AddReanimateFixPerk()

EndEvent
