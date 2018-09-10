Scriptname NEP_TargetCheckEffectScript extends ActiveMagicEffect
{Script to add reanimated actors to the reanimate fix tracking quest.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

NEP_ReanimateFixScript Property NEP_ReanimateFixQuest Auto
{Reanimate Fix Quext script.}

Faction Property SpellFaction = None Auto
{Optional faction to apply to the target.}

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Float fWait = 0.01

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor Target, Actor Caster)

  If SpellFaction
    Target.AddToFaction(SpellFaction)
  EndIf

  Debug.Trace("Reanimate cast on target: " + Target)

  Bool Done = NEP_ReanimateFixQuest.TrackZombie(Target)

  While !Done
    Utility.WaitMenuMode(fWait)
    Done = NEP_ReanimateFixQuest.TrackZombie(Target)
  EndWhile

  Self.Dispel()

EndEvent
