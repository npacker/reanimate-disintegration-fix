ScriptName RDF_InitScript Extends Quest
{Initialization script for reanimate fix quest.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Actor Property PlayerRef Auto
{The player.}

Perk Property RDF_ReanimateFixPerk Auto
{Perk that applies entry point for reanimate effect fix.}

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function AddReanimateFixPerk()

  If !PlayerRef.HasPerk(RDF_ReanimateFixPerk)
    PlayerRef.AddPerk(RDF_ReanimateFixPerk)
    Debug.TraceAndBox("Added Reanimate Disintegration Fix Perk.")
  EndIf

EndFunction

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnInit()

  Debug.Notification("Reanimate Disintegration Fix Quest Started")
  AddReanimateFixPerk()

EndEvent
