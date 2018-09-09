Scriptname NEP_TargetCheckEffectScript extends ActiveMagicEffect
{Script to add reanimated actors to the reanimate fix tracking quest.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

NEP_ReanimateFixScript Property NEP_ReanimateFixQuest Auto
{Reanimate Fix Quext script.}

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor Target, Actor Caster)

  NEP_ReanimateFixQuest.TrackZombie(Target)
  Self.Dispel()

EndEvent
